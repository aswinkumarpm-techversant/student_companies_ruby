class Student < User
  self.table_name = 'users'
  default_scope { User.where('role = ?', 'Student') }

  has_many :student_companies
  has_many :companies, through: :student_companies

end
