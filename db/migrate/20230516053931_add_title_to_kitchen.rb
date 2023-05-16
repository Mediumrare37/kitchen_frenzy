class AddTitleToKitchen < ActiveRecord::Migration[7.0]
  def change
    add_column :kitchens, :title, :string
  end
end
