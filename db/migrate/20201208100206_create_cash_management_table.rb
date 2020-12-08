class CreateCashManagementTable < ActiveRecord::Migration[6.0]
  def change
    create_table :cash_management_tables do |t|
      t.belongs_to :student_company
      t.string :cash_in
      t.string :cash_out
      t.string :initial_cash
      t.timestamps
    end
  end
end
