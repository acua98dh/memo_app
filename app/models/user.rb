class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
  # self.primary_key = "user_id"
  validates :name,  presence: true, length: { maximum: 50 }
  
  def feed
    Review.where("user_id = ?", id)
  end
  
end
