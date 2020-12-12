desc 'Whenever rake task test'
task whenever_call: :environment do
  Rails.logger.info "Whenever task"

  @cash_management_tables = CashManagementTable.all
  @cash_management_tables.each do |table|
    @cash_in_histories = CashInHistory.where("cash_management_table_id = ? AND status != ?", table.id, "done").order('created_at')
    @cash_out_histories = CashOutHistory.where("cash_management_table_id = ? AND status != ?", table.id, "done").order('created_at')
    puts @cash_in_histories.sum(:revenues_amount)
    puts @cash_out_histories.sum(:cogs_amount)

    total_cash_in = @cash_in_histories.sum(:revenues_amount) + @cash_in_histories.sum(:equity_amount) + @cash_in_histories.sum(:convertible_note_amount) + @cash_in_histories.sum(:bank_debt_amount) + @cash_in_histories.sum(:other_amount)
    total_cash_out = @cash_out_histories.sum(:cogs_amount) + @cash_out_histories.sum(:employees_amount) + @cash_out_histories.sum(:services_amount) + @cash_out_histories.sum(:operating_expenses_amount) + @cash_out_histories.sum(:investments_amount)
    puts total_cash_in
    puts total_cash_out
    puts table.initial_cash, "initial cash"
    if table.initial_cash.nil?
      final_initial_cash = total_cash_in - total_cash_out
    else
      puts "called"
      final_initial_cash = table.initial_cash.to_f + total_cash_in.to_f - total_cash_out.to_f
    end
    puts final_initial_cash
    @cash_in_histories.update_all(status: 'done')
    @cash_out_histories.update_all(status: 'done')
    table.update(initial_cash: final_initial_cash)
end
end
