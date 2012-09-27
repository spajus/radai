module ApplicationHelper
  def menu_item(item, item_class='', &block)
    item_class += " active" if "#{item}Controller".downcase == controller.class.name.downcase
    #raise controller.class.name.to_yaml
    "<li class=\"#{item_class.strip}\">#{capture(&block)}</li>".html_safe
  end

  def service_types
    ServiceType.all.collect {|t| [t.title, t.id]}.sort
  end
end
