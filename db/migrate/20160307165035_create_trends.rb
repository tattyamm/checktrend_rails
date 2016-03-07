class CreateTrends < ActiveRecord::Migration
  def change
    create_table :trends do |t|
      t.integer :group_id
      t.integer :rank
      t.string :keyword

      t.timestamps null: false
    end
  end
end
