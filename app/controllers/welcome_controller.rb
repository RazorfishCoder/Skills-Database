class WelcomeController < ApplicationController
  skip_filter :authenticate_user!, :only => [:login]
  def index
    Rails.logger.error('index action started')
    @title = 'Welcome'
    @events = EmployeeEvent.by_created_at(:limit => 10)
    @recent_searches = Search.by_created_at(:limit => 5)
    @most_viewed = Employee.by_num_views(:descending => true)
    Rails.logger.error('index action done, rendering')
  end

  def login
  end

end

