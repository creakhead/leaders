class ChangePeople < ActiveRecord::Migration
  def change
  	change_table :people do |t|
  		t.rename :brith_date, :birth_date
	end
  end
end
