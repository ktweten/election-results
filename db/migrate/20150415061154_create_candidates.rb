class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.integer :riding_id
      t.string :name
      t.integer :votes
      t.string :party_name

      t.timestamps
    end
  end
end
