class CreateCategoryWatchers < ActiveRecord::Migration
  def change
    create_table :category_watchers do |t|
      t.integer :category_id
      t.string :watchers
    end
  end
end