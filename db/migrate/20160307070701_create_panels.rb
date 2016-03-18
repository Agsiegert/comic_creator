class CreatePanels < ActiveRecord::Migration
  def change
    create_table :panels do |t|
      t.belongs_to :comic, index:true
      t.string :caption
      t.integer :image_index
      t.timestamps null: false
    end
  end
end
