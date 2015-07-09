class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def confirm_sign_in
      if cookies[:auth_token]
          user = User.find_by_auth_token!(cookies[:auth_token])
          session[:user_id] = user.id
          session[:email] = user.email
      else
          unless session[:user_id]
              flash[:notice] = 'Please log in.'
              redirect_to(:controller => 'auth', :action => 'get_sign_in')
              return false
          else
              return true
          end
      end
  end
end
