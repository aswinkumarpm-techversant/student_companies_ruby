class CreateCashInHistory < ActiveRecord::Migration[6.0]
  def change
    create_table :cash_in_histories do |t|
      t.belongs_to :cash_management_table
      t.decimal :revenues_amount, precision: 15, scale: 2
      t.decimal :equity_amount , precision: 15, scale: 2
      t.decimal :convertible_note_amount , precision: 15, scale: 2
      t.decimal :bank_debt_amount ,precision: 15, scale: 2
      t.decimal :other_amount ,precision: 15, scale: 2
      t.timestamps
    end
  end
end
