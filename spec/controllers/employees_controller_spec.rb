require 'spec_helper'

describe EmployeesController do

	describe "GET 'index'" do
		it "should be successful" do
  		pending
		end

		describe "with non loged in user" do
  		it "should redirect to linkedin login page" do
        get 'index'
        response.should redirect_to('/auth/linked_in')
  		end
		end
	end
end

