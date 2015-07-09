class PasswordResetsController < ApplicationController

    def new

    end

    def create
        user = User.find_by_email(params[:email])
        user.send_password_reset if user

        flash[:success] = "Password reset notification sent."
        redirect_to(:controller => 'auth', :action => 'get_sign_in')
    end

    def edit
        @user = User.find_by_password_reset_token!(params[:id])
    end

    def update
        @user = User.find_by_password_reset_token!(params[:id])

        if @user.password_reset_sent_at < 2.hours.ago
            flash[:notice] = "Password reset has expired."
            redirect_to(:action => 'new')
        elseif @user.update_attributes(params[:user])
            flash[:success] = "Password reset was successful. Please sign in."
            redirect_to(:controller => 'auth', :action => 'get_sign_in')
        else
            render(:edit)
        end
    end

end
