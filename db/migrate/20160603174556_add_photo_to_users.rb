class AddPhotoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :photo, :string    # for the unique user identifier from the provider
  end
end
