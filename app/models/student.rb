class Student < User
  self.table_name = 'users'
  default_scope { User.where('role = ?', 'Student') }
end
