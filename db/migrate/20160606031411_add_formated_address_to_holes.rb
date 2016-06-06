class AddFormatedAddressToHoles < ActiveRecord::Migration
  def change
    add_column :holes, :origen_address, :string
    add_column :holes, :destination_address, :string
  end
end
