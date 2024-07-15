module ButtonsMobileHelper
  def responsive_form_submit(form, value, classes)
    safe_join([
      form.submit(value, class: "#{classes} w-100 d-block d-md-none"),
      form.submit(value, class: "#{classes} d-none d-md-block")
    ])
  end
end  
