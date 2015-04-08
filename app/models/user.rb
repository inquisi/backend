class User < ActiveRecord::Base
  has_secure_password

  belongs_to :organization

  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: true, email: true

  after_create :generate_token

  def generate_token
    self.token = SecureRandom.uuid
  end

private
  # Make the 'token' setter private
  # So that it can't be set directly
  # It should be set with 'generate_token'
  def token=(t)
    write_attribute(:token, t)
  end
end
