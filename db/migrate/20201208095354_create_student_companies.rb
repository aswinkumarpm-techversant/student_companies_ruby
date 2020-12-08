class CreateStudentCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :student_companies do |t|
      t.belongs_to :company
      t.belongs_to :student
      t.timestamps
    end
  end
end
