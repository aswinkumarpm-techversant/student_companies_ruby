class AddTimestampToCashOutHistories < ActiveRecord::Migration[6.0]
  def change
    add_timestamps :cash_out_histories
  end
end
