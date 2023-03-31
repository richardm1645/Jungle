class User < ApplicationRecord
  before_validation :strip_whitespace

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }, confirmation: true 

  def authenticate_with_credentials(email, password)
    stripped_email = email.strip unless email.nil?
    stripped_password = password.strip unless password.nil?
    user = User.find_by_email(stripped_email)
    
    if user && user.authenticate(stripped_password)
      user
    else
      nil
    end
  end

  private

  def strip_whitespace
    self.email = email.strip unless email.nil?
  end
end
