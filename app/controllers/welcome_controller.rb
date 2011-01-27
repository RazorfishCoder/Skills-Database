class WelcomeController < ApplicationController
  def index
    @events = EmployeeEvent.all
  end
end

