class Review < ApplicationRecord
    has_many :review_tags, foreign_key: "review_id", dependent: :destroy
    validates :name, presence: true
    validates :rating, format: { with: /[1-5]/,message: "値が不正です" }
end
