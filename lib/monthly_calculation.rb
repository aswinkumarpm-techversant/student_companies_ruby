# module MonthlyCalculation
#   extend ActiveSupport::Concern
#   #
#   #
#   # included do
#   #   class_attribute :id
#   # end
#
#   def monthly_calculate
#     @cash_management_tables = CashManagementTable.all
#     @cash_management_tables.each do |table|
#       @cash_in_histories = CashInHistory.where("cash_management_table_id = ? AND status != ?", table.id, "done").order('created_at')
#       @cash_out_histories = CashOutHistory.where("cash_management_table_id = ? AND status != ?", table.id, "done").order('created_at')
#       total_cash_in = @cash_in_histories.sum(:revenues_amount) + @cash_in_histories.sum(:equity_amount) + @cash_in_histories.sum(:convertible_note_amount) + @cash_in_histories.sum(:bank_debt_amount) + @cash_in_histories.sum(:other_amount)
#       total_cash_out = @cash_out_histories.sum(:cogs_amount) + @cash_out_histories.sum(:employees_amount) + @cash_out_histories.sum(:services_amount) + @cash_out_histories.sum(:operating_expenses_amount) + @cash_out_histories.sum(:investments_amount)
#       if table.initial_cash.nil?
#         final_initial_cash = total_cash_in - total_cash_out
#       else
#         final_initial_cash = table.initial_cash + total_cash_in - total_cash_out
#       end
#       @cash_in_histories.update_all(status: 'done')
#       @cash_out_histories.update_all(status: 'done')
#       table.update(initial_cash: final_initial_cash)
#     end
#
#   end
#
#   # def print_aswin
#   #   puts "aswin, hi"
#   # end
#   #
#   #
#   # class_methods do
#   #   def monthly_parms(id)
#   #     self.id = id
#   #   end
#   # end
# end