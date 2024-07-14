RSpec.describe ButtonsMobileHelper do
  describe "#responsive_form_submit" do
    let(:form) { double("form") }
    let(:value) { "Submit" }
    let(:classes) { "btn btn-primary" }

    it "renders the submit button with appropriate classes for mobile and desktop" do
      expect(form).to receive(:submit).with(value, class: "#{classes} w-100 d-block d-md-none")
      expect(form).to receive(:submit).with(value, class: "#{classes} d-none d-md-block")

      helper.responsive_form_submit(form, value, classes)
    end
  end
end
