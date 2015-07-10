class ContactsController < ApplicationController

    before_action :authenticate_user!

    def index
        if params[:sort]
            @contacts = Contact.allContacts(current_user.id).order("#{params[:sort]} #{params[:direction].upcase}")
        else
            @contacts = Contact.allContacts(current_user.id).byLastName
        end

        render('index')
    end

    def search_contact
        query = params[:term]
        @contacts = Contact.allContacts(current_user.id).search(query)
        render json: @contacts
    end

    def details
        @contact = Contact.find(params[:id])
        render json: @contact
    end

    def show_create
        @contact = Contact.new

        render('create')
    end

    def create
        @contact = Contact.new(contact_params)
        @contact.user_id = current_user.id

        if @contact.save
            flash[:notice] = "The contact '#{@contact.first_name} #{@contact.last_name}' has been created."
            redirect_to(:action => 'index')
        else
            render('create')
        end
    end

    def edit
        @contact = Contact.find(params[:id])
        render('edit')
    end

    def update
        @contact = Contact.find(params[:id])

        if @contact.update_attributes(contact_params)
            flash[:notice] = "The contact '#{@contact.first_name} #{@contact.last_name}' has been updated."
            redirect_to(:action => 'index')
        else
            render('edit')
        end
    end

    def destroy
        @contact = Contact.find(params[:id])
        @contact.destroy
        flash[:notice] = "The contact '#{@contact.first_name} #{@contact.last_name}' has been deleted."
        redirect_to(:action => 'index')
    end

    private

        def contact_params
            params.require(:contact).permit(:first_name, :last_name, :email, :company, :notes, :user_id, :image)
        end

end
