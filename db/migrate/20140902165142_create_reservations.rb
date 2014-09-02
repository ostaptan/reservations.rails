class CreateReservations < ActiveRecord::Migration
  def up
    create_table :reservations do |t|
      t.integer :table_id
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end

  def down
    drop_table :reservations
  end
end
