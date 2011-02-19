class Post < ActiveRecord::Base
  
  belongs_to :category
  has_and_belongs_to_many :tags
  
  validates_presence_of :title, :body 
  
  accepts_nested_attributes_for :category, :tags, :reject_if => :all_blank
  
  has_attached_file :photo
  has_friendly_id :title, :use_slug => true, :scope => :category
  
  def next
    self.class.find :first, 
                    :conditions => ["created_at < ?", self.created_at],
                    :order => "created_at DESC"
  end
  
  def prev
    self.class.find :first,
                    :conditions => ["created_at > ?", self.created_at],
                    :order => "created_at ASC"
  end
    
end
