class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
			t.belongs_to :user, index: true
			t.belongs_to :seat, index: true
			t.integer :usage 
			t.timestamps
    end
  end
end
