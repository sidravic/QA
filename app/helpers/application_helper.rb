module ApplicationHelper
  def error_messages(object, field)    
    object.errors[field.to_sym][0]
  end
end
