class AddCategorytoKitchens < ActiveRecord::Migration[7.0]
  def change
    add_column :kitchens, :category, :string
  end
end
