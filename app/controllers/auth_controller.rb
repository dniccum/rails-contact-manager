class AuthController < ApplicationController

    def get_sign_up
        render('sign-up')
    end

    def get_sign_in
        render('sign-in')
    end

    def attempt_sign_in
        if params[:username].present? && params[:password].present?
            found_user = User.where(:username => params[:username]).first
            if found_user
                authorized_user = found_user.authenticate(params[:password])
            end
        end
        if authorized_user
            # mark user as logged in
            session[:user_id] = authorized_user.id
            session[:username] = authorized_user.username
            flash[:notice] = "You are now logged in."
            redirect_to(:action => 'menu')
        else
            flash[:notice] = "Invalid username/password combination."
            redirect_to(:action => 'get_sign_in')
        end
    end

    def logout
        # mark user as logged out
        session[:user_id] = nil
        session[:username] = nil
        flash[:notice] = "Logged out"
        redirect_to(:action => "get_sign_in")
    end

end
