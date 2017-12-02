class CreateCells < ActiveRecord::Migration[5.1]
  def change
    create_table :cells do |t|
      t.references :world, foreign_key: true
      t.string :status, default: 'live'
      t.integer :x, default: 0
      t.integer :y, default: 0

      t.timestamps
    end
  end
end
