class CreatePets < ActiveRecord::Migration[7.1]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :species
      t.string :breed
      t.integer :age
      t.string :image_url
      t.references :owner, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
