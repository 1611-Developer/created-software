class AddLinksToPost < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :repo_link, :string
    add_column :posts, :demo_link, :string
  end
end
