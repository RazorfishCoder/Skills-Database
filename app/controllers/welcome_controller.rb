class WelcomeController < ApplicationController
  def index
    if session[:atoken]
      linkedin = Linkedin.first
      client = LinkedIn::Client.new(linkedin.api_key, linkedin.secret_key)
      client.authorize_from_access(session[:atoken], session[:asecret])      
      @profile = client.profile(:fields => %w(id first-name last-name industry headline site-standard-profile-request))
    end
  end
end
