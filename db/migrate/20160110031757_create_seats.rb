class CreateSeats < ActiveRecord::Migration
  def change
    create_table :seats do |t|
    	t.belongs_to :owner, index: true
      t.timestamps
    end
  end
end
