class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
    	t.belongs_to :player, index: true
      t.timestamps
    end
    add_attachment :videos, :video
  end
end
