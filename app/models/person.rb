class Person < ActiveRecord::Base
	has_many :personal_records, dependent: :destroy
end
