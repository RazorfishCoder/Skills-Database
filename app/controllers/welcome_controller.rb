class WelcomeController < ApplicationController
  def index
    @title = 'Welcome'
    @events = EmployeeEvent.all
  end
end

