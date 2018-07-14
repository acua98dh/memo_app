class Review < ApplicationRecord
    has_many :review_tags, foreign_key: "review_id", dependent: :destroy
end
