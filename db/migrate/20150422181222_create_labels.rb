class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.string    :url, null: false
      t.string    :tracking_code, null: false
      t.string    :parcel_id, null: false
      t.string    :from_id, null: false
      t.string    :to_id, null: false

      t.timestamps
    end
  end
end
