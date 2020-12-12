# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "log/cron.log"
set :environment, "development"

#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

every 1.minute do
  rake "sample:test"
  runner "CashManagementTable.print_test"
end

# every 1.minute do
# end


every '0 0 28-31 * *' do
  runner "MonthlyCalculation.calculate_initial_cash"
  rake 'whenever_call'

end

# Learn more: http://github.com/javan/whenever
