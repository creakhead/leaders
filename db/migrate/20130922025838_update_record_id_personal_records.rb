class UpdateRecordIdPersonalRecords < ActiveRecord::Migration
  def change
  	add_column :personal_records, :record_id, :integer
  end
end
