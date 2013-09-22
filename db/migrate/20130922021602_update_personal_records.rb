class UpdatePersonalRecords < ActiveRecord::Migration
  def change
    add_column :personal_records, :url, :string
    add_column :personal_records, :sub_cat, :string
    add_column :personal_records, :result_time, :datetime
    remove_column :personal_records, :hour
    remove_column :personal_records, :min
    remove_column :personal_records, :sec
  end
end
