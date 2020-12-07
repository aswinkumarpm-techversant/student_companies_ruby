class Company < ActiveRecord::Base
  belongs_to :student
  has_one :cash_management_table
  # has_one :cash_in_history, through: :cash_management_table
  # has_one :cash_out_history, through: :cash_management_table
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :country, presence: true
  validates :currency, presence: true

end
