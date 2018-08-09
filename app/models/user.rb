class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :tags,through: :reviews
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, :omniauth_providers => [:github]
  validates :name, presence: true
  # self.primary_key = "user_id"
  validates :name,  presence: true, length: { maximum: 50 }
  
  def feed
    Review.where("user_id = ?", id)
  end
  
  def self.find_for_github_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    info = auth['info']
    unless user
      user = User.create(
                            name:     info['name'],
                            provider: auth.provider,
                            uid:      auth.uid,
                            email:    User.find_or_create_unique_email(info),
                            password: Devise.friendly_token[0,20]
      )
    end
    user
  end
  
  private

  def self.find_or_create_unique_email(info)
    if info['email'].present?
      info['email']
    else
      SecureRandom.uuid + "@example.com"
    end
  end
  
end
