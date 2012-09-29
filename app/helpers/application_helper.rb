module ApplicationHelper
  def menu_item(item, item_class='', &block)
    item_class += " active" if "#{item}Controller".downcase == controller.class.name.downcase
    #raise controller.class.name.to_yaml
    "<li class=\"#{item_class.strip}\">#{capture(&block)}</li>".html_safe
  end

  def service_types
    ServiceType.all.collect {|t| [t.title, t.id]}.sort
  end

  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                  hard_wrap: true,
                  autolink: true,
                  no_intra_emphasis: true,
                  tables: false,
                  superscript: true,
                  no_images: true,
                  no_styles: true,
                  safe_links_only: true,
                  filter_html: true
    )
    markdown.render(text).html_safe
  end
end
