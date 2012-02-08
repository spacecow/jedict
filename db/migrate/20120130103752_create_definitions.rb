class CreateDefinitions < ActiveRecord::Migration
  def change
    create_table :definitions do |t|
      t.string :reading
      t.integer :glossary_id

      t.timestamps
    end
  end
end
