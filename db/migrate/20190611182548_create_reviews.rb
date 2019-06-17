class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
    	t.integer :star
      t.text :comment
      t.string :type
      t.integer :buyer_id
      t.integer :seller_id
      t.references :package, references: :packages, index: true

      t.timestamps
    end
  end
end
