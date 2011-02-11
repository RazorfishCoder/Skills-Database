class WelcomeController < ApplicationController
  def index
    @title = 'Welcome'
    @events = EmployeeEvent.by_created_at(:limit => 10)
  end
end

