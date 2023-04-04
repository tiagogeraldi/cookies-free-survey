require 'rails_helper'

RSpec.describe "Contacts", type: :request do
  describe "GET /contacts" do
    it "renders thank you" do
      get contacts_url
      expect(response).to have_http_status(200)
      expect(response.body).to include 'Thank you'
    end
  end

  describe "GET /contacts/new" do
    it "renders thank you" do
      get new_contact_url
      expect(response).to have_http_status(200)
      expect(response.body).to include 'Contact us'
    end
  end

  describe "POST /contacts" do
    it "creates a contact" do
      expect {
        post contacts_url, params: { contact: { email: 'any', message: 'any' } }
      }.to change {
        Contact.count
      }.by(1)

      expect(response).to have_http_status(302)
    end

    it "does not create a contact" do
      expect {
        post contacts_url, params: { contact: { email: 'any', message: '' } }
      }.to change {
        Contact.count
      }.by(0)

      expect(response).to have_http_status(422)
    end
  end
end
