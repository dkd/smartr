# config/initializers/sunspot_index.rb
#ActsAsTaggableOn::Tagging.class_eval do
#  after_save :index_tag
# 
#  def index_tag
#    tag.index
#  end
#end
# 
#ActsAsTaggableOn::Tag.class_eval do
#  searchable do
#    text :name
#    integer :count do
#      self.taggings.count
#    end
#  end
#end