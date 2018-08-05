class Review < ApplicationRecord
    belongs_to :user
    default_scope -> { order('created_at DESC') }
    validates :user_id, presence: true
    validates :name, presence: true
    validates :rating, format: { with: /[1-5]/,message: "値が不正です" }


    has_and_belongs_to_many :tags
#    has_many :active_tags, class_name:  "review_tags", foreign_key: "review_id", dependent: :destroy
#    has_many :tagging, through: :active_tags, source: :tag

    # tagを追加する
#    def add_tag(something_tag)
#        active_tags.create(tag_id: something_tag.id)
#    end
    # tagを外す
#    def remove_tag(something_tag)
#        active_tags.find_by(tag_id: something_tag.id).destroy
#    end
    # すでにtagがついてたらtrueを返す
#    def tagging?(something_tag)
#        tagging.include?(something_tag)
#    end    


 
  def   save_reviews(savereview_tags)#
    current_tags = Tag.pluck(:name) unless Tag.nil?
    old_tags = current_tags - savereview_tags
    new_tags = savereview_tags - current_tags

    # Add old tags:
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end
    # Create new tags:
    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(name:new_name)
      self.tags << post_tag
    end
  end  
  
  def self.search(search) 
    if search #検索してる
      where(['name LIKE ?', "%#{search}%"]).or(where(['review LIKE ?', "%#{search}%"]))
    else #検索してない
      all
    end
  end
    
end
