class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.integer :wins, null: false, default: 0

      t.timestamps
    end

    create_table :players do |t|
    	t.belongs_to :team, index: true

    	t.string :name, null: false
    	t.integer :runs_count, null: false, default: 0

    	t.timestamps

    end
  end
end
