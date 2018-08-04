class Tag < ApplicationRecord

has_and_belongs_to_many :reviews

#    has_many :review_tags, foreign_key: "tag_id", dependent: :destroy
#    has_many :taggers, through: :review_tags, source: :review

end
