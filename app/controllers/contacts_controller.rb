class ContactsController < ApplicationController

    before_action :confirm_sign_in

    def index
        render('index')
    end

    def show_create
        render('create')
    end

    def create

    end
    
end
