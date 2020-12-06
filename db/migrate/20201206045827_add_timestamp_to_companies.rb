class AddTimestampToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_timestamps :companies
  end
end
