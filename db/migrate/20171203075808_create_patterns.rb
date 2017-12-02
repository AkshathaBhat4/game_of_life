class CreatePatterns < ActiveRecord::Migration[5.1]
  def change
    create_table :patterns do |t|
      t.string :name
      t.string :default_state

      t.timestamps
    end
  end
end
