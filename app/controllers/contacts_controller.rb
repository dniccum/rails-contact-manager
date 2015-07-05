class ContactsController < ApplicationController

    before_action :confirm_sign_in

    def index
        @contacts = Contact.allContacts(session[:user_id]).byLastName

        render('index')
    end

    def show_create
        @contact = Contact.new

        render('create')
    end

    def create
        @contact = Contact.new(contact_params)
        @contact.user_id = session[:user_id]

        if @contact.save
            flash[:success] = "The contact '#{@contact.first_name} #{@contact.last_name}' has been created."
            redirect_to(:action => 'index')
        else
            flash[:notice] = "Please complete all fields."
            render('create')
        end
    end

    def edit
        @contact = Contact.find(params[:id])
        render('edit')
    end

    private

        def contact_params
            params.require(:contact).permit(:first_name, :last_name, :email, :company, :notes, :user_id)
        end

end
