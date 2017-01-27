class User < ApplicationRecord

  has_many :events
  has_many :images, through: :events
  has_many :comments

  has_secure_password

  validates_presence_of :email
	validates_uniqueness_of :email

  # works for facebook
  def self.from_omniauth(auth_hash)
    self.where(:email => auth_hash['info']['email']).first_or_create do |user|
      user.password = SecureRandom.hex
    end
  end
end

  # below not used because of invalid SSL Cert issue
  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.name = auth.info.name
  #     user.email = auth.info.email
  #     user.save!
  #   end
  # end

#   def self.from_omniauth(auth_hash)
#     user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
#     user.name = auth_hash['info']['name']
#     user.email = auth_hash['info']['email']
#     user.password = SecureRandom.hex
#     user.save!
#     user
#   end
