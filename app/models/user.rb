# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  provider               :string
#  uid                    :integer
#  description            :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  avatar                 :string
#  language               :string
#  country                :string
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2, :facebook]
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader
  has_many :services, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_services, through: :favorites, source: :service
  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :order_items, through: :orders

  
  validates :email, uniqueness: true, presence: true
  
  # def check_avatar
  #   if self.avatar.blank?
  #     self.avatar = "https://via.placeholder.com/150"
  #   else
  #     avatar_url
  #   end
  # end

  def seller?
    self[:language].present? && self[:name].present? && self[:country].present? && self[:description].present?
  end

  def buyer_review_star
    if self.services.present?
      if self.services.size == 0
        return 0
      else
        self.services.each do |service|
          if service.buyer_review_star.present?
            results = []
            results << service.buyer_review_star.to_i
            total = results.sum
            return (total/results.length).round(1)
          end
        end
      end
    else
      return 0
    end
  end

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    user ||= User.create!(provider: auth.provider, name: auth.info.name, email: auth.info.email, password: Devise.friendly_token[0,20])
    user
  end

  # def create_with_omniauth(auth)
    
  # end

  # def from_omniauth_backup
        # find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
    # if false
      # user = User.where(provider: auth.provider, email: auth.info.email).first
      # where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      #   user.provider = auth.provider
      #   user.uid = auth.uid
      #   user.name = auth.info.name
      #   user.email = auth.info.email
      #   user.password = Devise.friendly_token[0,20]
      #   # user.oauth_token = auth.credentials.token
      #   # user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      #   user.save!
      # end
    # end

    # if false
    #   data = access_token.info
    #   user = User.where(email: data['email']).first
    #   user ||= User.create(name: data['name'], email: data['email'], password: Devise.friendly_token[0,20])
    #   user
    # end
  # end

end

