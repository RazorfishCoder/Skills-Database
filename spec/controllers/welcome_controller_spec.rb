require 'spec_helper'

describe WelcomeController do
  describe "index" do
    describe "with non loged in user" do
      it "should redirect to linkedin login page" do
        get 'index'
        response.should redirect_to('/auth/linked_in')
      end
    end
  end
end

