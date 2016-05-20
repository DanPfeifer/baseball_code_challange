class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
    	t.integer :away_team_id, index: true
    	t.integer :home_team_id, index: true
    	t.integer :winner_id
    	t.integer :away_runs, null: false, default: 0
    	t.integer :home_runs, null: false, default: 0
    	t.datetime :runs_updated_at
      t.timestamps
    end

    create_table :runs do |t|
    	t.belongs_to :player, index: true
    	t.belongs_to :game, index: true
    	t.timestamps
    end
  end
end
