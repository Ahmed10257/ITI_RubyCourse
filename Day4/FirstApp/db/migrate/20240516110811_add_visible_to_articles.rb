class AddVisibleToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :visible, :boolean
  end
end
