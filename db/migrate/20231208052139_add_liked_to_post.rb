class AddLikedToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :liked, :boolean, default: false
  end
end
