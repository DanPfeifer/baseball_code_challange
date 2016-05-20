class CreateHighlights < ActiveRecord::Migration[5.0]
  def change
    create_table :highlights do |t|
    	t.belongs_to :player, index: true
      t.timestamps
    end
    add_attachment :highlights, :highlight
  end
end
