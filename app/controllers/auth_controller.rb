class AuthController < ApplicationController

    def get_sign_up
        render('sign-up')
    end

    def get_sign_in
        render('sign-in')
    end
end
