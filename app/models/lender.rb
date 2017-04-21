class Lender < ActiveRecord::Base
  has_secure_password
  has_many :borrowers, through: :transactions

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :money, presence: true, :numericality => { :greater_than => 0 }
  validates :password, presence: true, length: { minimum: 5 }, on: [:create]
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  
  before_save :email_lowercase

  def email_lowercase
    email.downcase!
  end

end
