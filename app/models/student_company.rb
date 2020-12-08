class StudentCompany < ApplicationRecord
  belongs_to :student
  belongs_to :company
  has_one :cash_management_table

end
