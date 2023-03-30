class ContactsController < ApplicationController
  layout 'quiz'

  def index
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # POST /contacts or /contacts.json
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      redirect_to contacts_url
    else
      flash[:error] = @contact.errors.full_messages.join('. ')
      render :new, status: :unprocessable_entity
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:email, :message)
    end
end
