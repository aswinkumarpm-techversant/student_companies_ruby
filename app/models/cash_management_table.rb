class CashManagementTable < ActiveRecord::Base
  belongs_to :student_company
  has_many :cash_in_histories
  has_many :cash_out_histories




  def self.calculate_initial_cash
    @cash_in_histories = CashInHistory.where("cash_management_table_id = ? AND status != ?", self.id, "done").order('created_at')
    @cash_out_histories = CashOutHistory.where("cash_management_table_id = ? AND status != ?", self.id, "done").order('created_at')
    total_cash_in = ''
    total_cash_out = ''
    @cash_in_histories.each do |cash_in_history|
      total_cash_in = cash_in_history.revenues_amount + cash_in_history.equity_amount + cash_in_history.convertible_note_amount  + cash_in_history.bank_debt_amount  + cash_in_history.other_amount
    end
    @cash_out_histories.each do |cash_out_history|
      total_cash_out = cash_out_history.cogs_amount + cash_out_history.employees_amount + cash_out_history.services_amount  + cash_out_history.operating_expenses_amount  + cash_out_history.investments_amount
    end
    if self.initial_cash.nil?
      final_initial_cash = total_cash_in - total_cash_out
    else
      final_initial_cash = self.initial_cash + total_cash_in - total_cash_out
    end
    @cash_in_histories.update_all(status: 'done')
    @cash_out_histories.update_all(status: 'done')
    self.initial_cash = final_initial_cash
    end
end

