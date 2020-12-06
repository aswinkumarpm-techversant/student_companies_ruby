class CashManagementTable < ActiveRecord::Base
  belongs_to :company
  has_one :cash_in_history
  has_one :cash_out_history

end

