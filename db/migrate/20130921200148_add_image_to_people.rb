class AddImageToPeople < ActiveRecord::Migration
  def change
    add_column :people, :image, :string
    add_column :people, :gender, :string
  end
end
