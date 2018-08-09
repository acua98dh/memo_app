class Tag < ApplicationRecord

    has_and_belongs_to_many :reviews
    has_many :users,through: :reviews

end
