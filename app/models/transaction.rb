class Transaction < ActiveRecord::Base
  belongs_to :lender
  belongs_to :borrower

  validates :money_lent, presence: true, :numericality => { :greater_than => 0 }

end
