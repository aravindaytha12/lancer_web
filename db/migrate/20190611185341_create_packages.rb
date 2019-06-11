class CreatePackages < ActiveRecord::Migration[5.2]
  def change
    create_table :packages do |t|
    	t.string :name
      t.references :service
      t.integer :price
      t.text :description
      t.boolean :is_commercial
      t.integer :revision_number
      t.integer :delivery_time

      t.timestamps
    end
  end
end
