class TagsController < ApplicationController
  
  def index

    if params[:q].present?
      @tags = ActsAsTaggableOn::Tag.group('tags.id').joins(:taggings).select("count(*) as count,tags.id,tags.name").order('count(*) desc').where("name like ?","#{params[:q]}%").paginate :page => params[:page], :per_page => 60
    else
      @tags = ActsAsTaggableOn::Tag.group('tags.id').joins(:taggings).select("count(*) as count,tags.id,tags.name").order('count(*) desc').paginate :page => params[:page], :per_page => 60
    end
    
    respond_to do |format|      
      format.html{ puts "yeah html"}
      format.js{ render :partial => "list"}
      format.json{ render :json => @tags.map { |tag| tag.name}.to_json }
    end
  end
  
end