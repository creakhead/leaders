class PersonalRecord < ActiveRecord::Base
  belongs_to :person
  has_one :event_type
end
