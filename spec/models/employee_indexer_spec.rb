require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EmployeeIndexer do
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:index) { IndexTank::Client.new(API_URL).indexes(INDEX_NAME) }
  let(:path_prefix) { '/v1/indexes/idx/' }
     
  before { stub_setup_connection }

  describe "#exists?" do
    subject { index.exists? }

    context "when an index exists" do
       before do
           stubs.get(path_prefix) { [200, {}, '{"started": false, "code": "dsyaj", "creation_time": "2010-08-14T13:01:48.454624", "size": 0}'] }
       end
             
       it { subject.should be_true }
    end
            
    context "when an index doesn't exist" do
       before do
           stubs.get(path_prefix) { [404, {}, ''] }
       end
                        
       # rspec2 bug, implicit subject is calling subject twice
       it { subject.should be_false }
    end
  end
                        
  describe "#search" do
     subject { index.search('__any:(java)') }
                        
     context "search is successful" do
       before do
           stubs.get("#{path_prefix}search?q=__any:(java)&start=0&len=10") { [200, {}, '{"matches"=>4, "facets"=>{}, "search_time"=>"0.002", "results"=>[{"ocid"=>"iY7PJGFcyp"}, {"ocid"=>"FIzlSsMz3"}, {"docid"=>"Tzb-cLr90-"}, {"ocid"=>"ZekjEIF-XL"}"]}'] }
       end

       it "should have the number of matches" do
           subject['matches'].should == 4
       end
                        
       it "should a list of docs" do
           results = subject['results']
           %w(iY7PJGFcyp
              kFIzlSsMz3
              Tzb-cLr90-
              ZekjEIF-XL).each_with_index do |docid, index|
                  results[index]['docid'].should == docid
           end
       end
     end

     context "index is initializing", :pending => true do
       before do
           stubs.get("#{path_prefix}search") { [409, {}, ''] }
       end

       it "should return an empty body"
     end

     context "index is invalid/missing argument", :pending => true do
       before do
           stubs.get("#{path_prefix}search") { [400, {}, ''] }
       end

       it "should return a descriptive error message"
     end

     context "no index existed for the given name", :pending => true do
       before do
           stubs.get("#{path_prefix}search") { [404, {}, ''] }
       end

       it "should return a descriptive error message"
     end
  end
end
