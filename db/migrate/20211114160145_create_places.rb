class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|
      # NOTE! a primary key column named "id" will be created by default
      t.string :name, null: false
      t.string :description
      t.float :latitude
      t.float :longitude

      # NOTE! this creates "created_at" and "updated_at" columns
      t.timestamps
    end

    add_index :places, :name, unique: true

  end
end
