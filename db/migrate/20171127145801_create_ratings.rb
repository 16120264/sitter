class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :stars
      t.integer :client
      t.integer :sitter
      t.references :booking, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
