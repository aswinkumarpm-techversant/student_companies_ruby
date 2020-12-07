class CashManagementTable < ActiveRecord::Base
  belongs_to :company
  has_many :cash_in_histories
  has_many :cash_out_histories

end

