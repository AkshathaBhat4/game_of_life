class CreateWorlds < ActiveRecord::Migration[5.1]
  def change
    create_table :worlds do |t|
      t.integer :generation_count, default: 0
      t.integer :top_x, default: 0
      t.integer :top_y, default: 0
      t.integer :bottom_x, default: 0
      t.integer :bottom_y, default: 0

      t.timestamps
    end
  end
end
