module ButtonsMobileHelper
  def is_mobile_device?
    request.user_agent =~ /Mobile/
  end

  def primary_button_class
    "btn btn-primary btn-lg #{is_mobile_device? ? 'w-100' : ''}"
  end

  def secondary_button_class
    "btn btn-secondary btn-lg #{is_mobile_device? ? 'w-100' : ''}"
  end
end