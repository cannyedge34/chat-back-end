class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :content
      t.string :created_by
      t.references :room, foreign_key: true
      t.timestamps
    end
  end
end
