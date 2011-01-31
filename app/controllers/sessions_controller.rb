class SessionsController < ApplicationController
  skip_filter :authenticate_user!, :only => [:create]

  def create
    auth = request.env['rack.auth']
    unless @auth = Authorization.find_from_hash(auth)
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Authorization.create_from_hash(auth, current_user)
    end

    if @auth
      # Log the authorizing user in.
      self.current_user = @auth.employee
    else
      flash[:notice] = 'You must work on Razorfish or Globant'
    end

    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end

