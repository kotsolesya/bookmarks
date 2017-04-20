class AddScreenshotUrlToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :screenshot_url, :string
  end
end
