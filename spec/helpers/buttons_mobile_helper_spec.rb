# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ButtonsMobileHelper, type: :helper do
  describe '#is_mobile_device?' do
    it 'returns true when the user agent indicates a mobile device' do
      allow(helper).to receive(:request).and_return(double(user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1 Mobile/15E148 Safari/604.1'))
      
      expect(helper.is_mobile_device?).to be true
    end

    it 'returns false when the user agent does not indicate a mobile device' do
      allow(helper).to receive(:request).and_return(double(user_agent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'))
      
      expect(helper.is_mobile_device?).to be false
    end
  end

  describe '#primary_button_class' do
    it 'returns the CSS class for primary buttons' do
      expect(helper.primary_button_class).to eq 'btn-primary'
    end
  end

  describe '#secondary_button_class' do
    it 'returns the CSS class for secondary buttons' do
      expect(helper.secondary_button_class).to eq 'btn-secondary'
    end
  end
end