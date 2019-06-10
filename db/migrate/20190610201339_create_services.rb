class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|

      t.timestamps
    end
  end
end
