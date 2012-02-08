class CreateMeanings < ActiveRecord::Migration
  def change
    create_table :meanings do |t|
      t.string :content
      t.integer :definition_id

      t.timestamps
    end
  end
end
