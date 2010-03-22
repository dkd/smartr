# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def main_menu(active)
      menu = []
      menu << {:name => "Questions", :id => "questions", :link => questions_path}
      menu << {:name => "Tags", :id => "tags", :link => url_for(:controller => :tags, :action => :index, :tag => nil)}
      menu << {:name => "Users", :id => "users", :link => users_path}
      content_for :main_menu, build_menu(menu, active)
  end
  
  def build_menu(menu, active)
      li = ""
      menu.each do |m|
        class_name = (m[:id]==active.to_s)? 'active' : ''
        li +=content_tag(:li, link_to(m[:name], m[:link]), :class => class_name)
      end
      content_tag(:ul, li)
    end
  
  def correct_plural()
    
  end
  
  def fancy_flash
    
  end
  
  def code(html)
    auto_link(Sanitize.clean(BlueCloth.new(html).to_html,
        :elements => ['br','strong','ul','ol','blockquote','li','a','h1','h2','h3','p','span','pre','code','div','img'], 
        :attributes =>{
          'a' => ['href','title'],
          'img' => ['src','title','alt']
        }))
  end
  
  def current_url
    port = ""
    port = ":#{request.port}" unless request.port == 80
    request.host + port 
  end
  
end
