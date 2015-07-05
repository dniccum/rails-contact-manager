class AuthController < ApplicationController

    before_action :confirm_sign_in, :except => [:get_sign_up, :sign_up, :get_sign_in, :attempt_sign_in, :logout]

    def get_sign_up
        @user = User.new

        render('sign-up')
    end

    def sign_up
        @user = User.new(user_params)

        if @user.save
            session[:user_id] = @user.id
            session[:email] = @user.email
            flash[:success] = "You are now signed up and logged in."
            redirect_to(:controller => 'contacts', :action => 'index')
        else
            flash[:notice] = "Please complete all fields."
            render('sign-up')
        end
    end

    def get_sign_in
        render('sign-in')
    end

    def attempt_sign_in
        if params[:email].present? && params[:password].present?
            found_user = User.where(:email => params[:email]).first
            if found_user
                authorized_user = found_user.authenticate(params[:password])
            end
        end
        if authorized_user
            session[:user_id] = authorized_user.id
            session[:email] = authorized_user.email
            flash[:success] = "You are now logged in."
            redirect_to(:controller => 'contacts', :action => 'index')
        else
            flash[:notice] = "Invalid username/password combination."
            redirect_to(:action => 'get_sign_in')
        end
    end

    def logout
        session[:user_id] = nil
        session[:email] = nil
        flash[:success] = "Logged out"
        redirect_to(:action => "get_sign_in")
    end

    private

        def user_params
            params.require(:user).permit(:first_name, :last_name, :email, :password)
        end

end
