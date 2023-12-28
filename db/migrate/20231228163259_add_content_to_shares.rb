class AddContentToShares < ActiveRecord::Migration[7.0]
  def change
    add_column :shares, :content, :text
  end
end
