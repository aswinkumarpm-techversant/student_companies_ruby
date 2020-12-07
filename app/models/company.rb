class Company < ActiveRecord::Base
  belongs_to :student
  has_many :cash_management_tables
  has_many :cash_in_histories
  has_many :cash_out_histories
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :country, presence: true
  validates :currency, presence: true

end
