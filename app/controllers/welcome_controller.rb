class WelcomeController < ApplicationController
  def index
    @title = 'Welcome'
    @events = EmployeeEvent.by_created_at(:limit => 10)
    @recent_searches = Search.by_created_at(:limit => 5)
  end
end

