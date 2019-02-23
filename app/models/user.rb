class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :username, uniqueness: true

  attr_reader :password
  after_initialize :ensure_session_token

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    return self.session_token
  end
  
  def self.find_by_credentials(name, pass)
    user = User.find_by(username: name)
    if user && user.is_password?(pass)
      return user
    else
      return nil
    end
  end

  def password=(pass)
    @password = pass
    self.password_digest = BCrypt::Password.create(pass)
  end
  
  def is_password?(pass)
    BCrypt::Password.new(self.password_digest).is_password?(pass)
  end

end
