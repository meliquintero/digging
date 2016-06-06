class CreateHoles < ActiveRecord::Migration
  def change
    create_table :holes do |t|
      t.string :current_user_id, null: false
      t.decimal :origin_latitud, null: false
      t.decimal :origin_longitud, null: false
      t.string :origin_image, null: false
      t.decimal :destination_latitud
      t.decimal :destination_longitud
      t.string :destination_image
      t.timestamps null: false
    end
  end
end
