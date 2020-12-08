class CompanySerializer < ActiveModel::Serializer
  attributes :name, :country, :currency, :student_id
end
