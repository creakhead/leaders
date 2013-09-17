class CreatePersonalRecords < ActiveRecord::Migration
  def change
    create_table :personal_records do |t|
      t.belongs_to :person, index: true
      t.belongs_to :event_type
      t.integer :hour
      t.integer :min
      t.integer :sec
      t.string :event_name

      t.timestamps
    end
  end
end
