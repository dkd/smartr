# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def is_owner?(obj)
    return false if obj == nil
    obj.user == current_user
  end

  def direction(value)
    value==1 ? "up" : "down"
  end

  def button_tag(value, options)
    content_tag(:button, t(value), options)
  end

  def can_edit?(object)
     return false if !user_signed_in?
     return true if (current_user == object.user) || current_user.is_admin?
  end

  def main_menu(active)
      menu = []
      menu << {:name => I18n.t(:"main_menu.questions"), :id => "questions", :link => root_url}
      menu << {:name => I18n.t(:"main_menu.tags"), :id => "tags", :link => tags_path}
      menu << {:name => I18n.t(:"main_menu.users"), :id => "users", :link => users_path}
      #menu << {:name => 'Admin', :id => "admin", :link => admin_url} if is_admin?
      content_for :main_menu, build_menu(menu, active, "nav")
  end

  def title(name, subtitle="", page_header_infobox="")
    content_for :title, name
    content_for :subtitle, subtitle unless subtitle.blank?
    content_for :html_title, Sanitize.clean(name)
    content_for :page_header_infobox, page_header_infobox
  end

  def image_for(user, size)
    image_tag(user.avatar.url(size.to_sym))
  end

  def build_menu(menu, active, css_class = "")
    li = ""
    menu.each do |m|
      class_name = (m[:id]==active.to_s)? 'active' : ''
      li +=content_tag(:li, link_to(m[:name], m[:link]), :class => class_name)
    end
    content_tag :ul, raw(li), :class => css_class
  end

  def code(html)
    auto_link(Sanitize.clean(BlueCloth.new(html).to_html,
        :elements => ['br','strong','ul','ol','blockquote','hr','li','a','h1','h2','h3','p','span','pre','code','div','img'],
        :attributes =>{
          'a' => ['href','title'],
          'img' => ['src','title','alt']
        }))
  end

  def mark_required(model, attribute)
    "*" if model.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
  end

#  def page_entries_info(collection)
#    "FIXME!!!"
#  end

end