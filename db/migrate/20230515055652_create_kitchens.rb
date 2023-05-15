class CreateKitchens < ActiveRecord::Migration[7.0]
  def change
    create_table :kitchens do |t|
      t.text :details
      t.string :location
      t.float :price_per_day
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
