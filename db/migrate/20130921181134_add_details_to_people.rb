class AddDetailsToPeople < ActiveRecord::Migration
  def change
  	add_column :people, :provider, :string
  	add_column :people, :uid, :string
  	add_column :people, :oauth_token, :string
  	add_column :people, :oauth_expires, :datetime
  end
end
