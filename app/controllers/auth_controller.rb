class AuthController < ApplicationController
  def index
    #Load the api and secret key for the linkedin application
    linkedin = Linkedin.first
    
    #TODO: Figure out what to do if the api and secret key are missing from db...should not be hard-coded.
    
    if session[:atoken].nil?
      client = LinkedIn::Client.new(linkedin.api_key, linkedin.secret_key)
      request_token = client.request_token(:oauth_callback =>"http://#{request.host_with_port}/auth/callback")
      session[:rtoken] = request_token.token
      session[:rsecret] = request_token.secret
      redirect_to client.request_token.authorize_url
    else
      redirect_to :action => 'callback'
    end
    
  end

  def callback
    #Load the api and secret key for the linkedin application
    linkedin = Linkedin.first
    
    #TODO: Figure out what to do if the api and secret key are missing from db...should not be hard-coded.
    
    client = LinkedIn::Client.new(linkedin.api_key, linkedin.secret_key)
    if session[:atoken].nil?
      pin = params[:oauth_verifier]
      atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
      session[:atoken] = atoken
      session[:asecret] = asecret
    else
      client.authorize_from_access(session[:atoken], session[:asecret])
    end
    #Grab the linked in profile information we want to store in couch
    @profile = client.profile(:fields => %w(id first-name last-name industry headline site-standard-profile-request))
    
    #Create a new Employee and save if not present already
    employee = Employee.new
    employee.linkedin_id = @profile.id
    employee.first_name = @profile.first_name
    employee.last_name = @profile.last_name
    employee.industry = @profile.industry
    employee.job_title = @profile.headline
    employee.linkedin_url = @profile.site_standard_profile_request.url
    if employee.save
      flash[:notice] = 'The user has been added to couch!'
    else
      flash[:error] = 'User not added...could already be in there!'
    end
  end

  def logout
    session[:atoken] = nil
    session[:rtoken] = nil
    session[:rsecret] = nil
    redirect_to :action => 'index'
  end
    
end