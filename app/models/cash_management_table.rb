class CashManagementTable < ActiveRecord::Base
  belongs_to :student_company
  has_many :cash_in_histories
  has_many :cash_out_histories
end

