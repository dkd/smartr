class TagsController < ApplicationController
  respond_to :html, :js, :json

  def index
    if params[:tags].present? && params[:tags][:q].present?
      @q = params[:tags][:q]
      @tags = Question.tags.where("tags.name like ?", "%#{params[:tags][:q]}%").paginate(params[:page])
    else
      @tags = Question.tags.paginate(:page => params[:page], :per_page => 60)
    end
    respond_to do |format|
      format.html
      format.js { render :partial => "list", :locals => { :tags => @tags }}
      format.json { render :json => @tags.map { |tag| tag.name}.to_json }
    end
  end

end