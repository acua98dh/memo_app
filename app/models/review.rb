class Review < ApplicationRecord
    belongs_to :user
    belongs_to :user
    default_scope -> { order('created_at DESC') }
    validates :user_id, presence: true

    has_many :review_tags, foreign_key: "review_id", dependent: :destroy
    validates :name, presence: true
    validates :rating, format: { with: /[1-5]/,message: "値が不正です" }
end
