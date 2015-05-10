class CreateRidings < ActiveRecord::Migration
  def change
    create_table :ridings do |t|
      t.string :name
      t.string :region

      t.timestamps
    end
  end
end
