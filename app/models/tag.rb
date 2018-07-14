class Tag < ApplicationRecord
    has_many :review_tags, foreign_key: "tag_id"
end
