class CreateCategoryWatchers < ActiveRecord::Migration[5.2]
  def change
    create_table :category_watchers do |t|
      t.integer :category_id
      t.string :watchers
    end
  end
end