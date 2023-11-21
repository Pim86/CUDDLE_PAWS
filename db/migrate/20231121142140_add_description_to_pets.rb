class AddDescriptionToPets < ActiveRecord::Migration[7.1]
  def change
    add_column :pets, :description, :text
  end
end
