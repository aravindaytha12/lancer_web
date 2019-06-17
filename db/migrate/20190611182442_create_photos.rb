class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.text :description
      t.references :service, references: :services, index: true
      t.timestamps
    end
  end
end