class AlterTitleFromImages < ActiveRecord::Migration[5.2]
  def change
    change_column :images, :title, :string, null: false
  end
end
