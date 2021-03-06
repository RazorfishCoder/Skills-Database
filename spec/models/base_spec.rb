require 'spec_helper'
require File.join(FIXTURE_PATH, 'base_fixture')

describe BaseCouchDocument do

  before(:each) do
    @obj = BaseFixture.new
  end
  
  describe "instance database connection" do
      it "should use the default database" do
        @obj.database.name.should == "skillsdb-#{Rails.env}"
      end

      it "should override the default db" do
        @obj.database = CouchServer.database!('couchrest-extendedmodel-test')
        @obj.database.name.should == 'couchrest-extendedmodel-test'
        @obj.database.delete!
      end
  end
  
  describe "a new model" do
      it "should be a new document" do
        @obj.rev.should be_nil
        @obj.should be_new
        @obj.should be_new_document
        @obj.should be_new_record
      end

      it "should not failed on a nil value in argument" do
        @obj = BaseFixture.new(nil)
        @obj.should_not be_nil
      end
  end

end

