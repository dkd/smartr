class TagsController < ApplicationController
  def index
      @tags = Question.tag_counts
  end
end