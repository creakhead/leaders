class UpdateMorePersonalRecords < ActiveRecord::Migration
  def change
  	add_column :personal_records, :event_id, :integer
  	add_column :personal_records, :sub_event_id, :integer
  	add_column :personal_records, :pr, :boolean
  end
end
