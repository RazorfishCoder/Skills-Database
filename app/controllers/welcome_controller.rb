class WelcomeController < ApplicationController
  def index
    @linkedin = Linkedin.first
  end

end
