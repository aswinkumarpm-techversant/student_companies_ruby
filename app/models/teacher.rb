class Teacher < User
  self.table_name = 'users'
  default_scope { User.where('role = ?', 'Teacher') }

end
