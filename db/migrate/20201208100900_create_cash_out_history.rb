class CreateCashOutHistory < ActiveRecord::Migration[6.0]
  def change
    create_table :cash_out_histories do |t|
      t.belongs_to :cash_management_table
      t.decimal :cogs_amount, precision: 15, scale: 2
      t.decimal :employees_amount , precision: 15, scale: 2
      t.decimal :services_amount , precision: 15, scale: 2
      t.decimal :operating_expenses_amount ,precision: 15, scale: 2
      t.decimal :investments_amount ,precision: 15, scale: 2
      t.timestamps
    end
  end
end
