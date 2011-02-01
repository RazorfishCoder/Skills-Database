require 'spec_helper'

describe Authorization do
	before :each do
		#Extract to fixtures
		Authorization.create(:provider => 'linked_in', :uid => 'testtest')
		Authorization.create(:provider => 'linked_in', :uid => 'testtest2')
	end

	describe "views" do
		describe "uid and provider" do
			it "should return an authorization" do
				auth = Authorization.find_by_provider_and_uid(['linked_in', 'testtest'])
				auth.should_not be_nil
			end

			it "should return only one authorization" do
				auth = Authorization.find_by_provider_and_uid(['linked_in', 'testtest'])
				auth.should be_a_kind_of(Authorization)
			end
		end
	end

	describe "validations" do
		it "should not be valid with an existing uid" do
		  authorization = Authorization.new(:provider => 'linked_in', :uid => 'testtest')
			authorization.should_not be_valid
		end
	end
end

