class Review < ApplicationRecord
    belongs_to :user
    has_and_belongs_to_many :tags

    default_scope -> { order('created_at DESC') }

    validates :user_id, presence: true
    validates :name, presence: true
    validates :rating, format: { with: /[1-5]/,message: "値が不正です。１〜５の値にしてください。" }

  def   save_reviews(savereview_tags)#
    current_tags = Tag.pluck(:name) unless Tag.nil?
    new_tags = savereview_tags - current_tags
    old_add_tags = savereview_tags - new_tags
    old_del_tags = current_tags - savereview_tags

    # old tags:
    if !self.tags.empty?
      old_del_tags.each do |old_name|
        self.tags.delete Tag.find_by(name:old_name)
      end
    end
    old_add_tags.each do |old_name|
      self.tags << Tag.find_by(name:old_name)
    end
    
    # Create new tags:
    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(name:new_name)
      self.tags << post_tag
    end
  end  
  
  def self.search(search,filing) 
    if search #検索してる
      if filing == "review"
        where(['name LIKE ?', "%#{search}%"]).or(where(['review LIKE ?', "%#{search}%"]))
      elsif filing == "tag"
        joins(:tags).where(['tags.name LIKE ?', "%#{search}%"])
      end
    else #検索してない
      all
    end
  end
  
    
end
