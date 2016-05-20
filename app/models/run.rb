# == Schema Information
#
# Table name: runs
#
#  id              :integer         not null, primary key
#  player_id       :integer
#  game_id	   		 :integer
#  created_at      :datetime       
#  updated_at      :datetime
#

class Run < ApplicationRecord

	belongs_to :player, counter_cache: true
  has_one :team, through: :player
	belongs_to :game, :touch => :runs_updated_at

  validates_presence_of :player_id, :game_id
  validates_associated :team
  validate :team_in_game

	after_save :update_game_runs

		def api_attributes
			attributes = {
				"id" => id,
				"game" => game_id,
				"player" => player,
				"created_at" => created_at,
				"updated_at" => updated_at
			}
		end
	private
		def update_game_runs
			self.game.update_runs(self.team)
		end

		def team_in_game
			unless [game.away_team_id, game.home_team_id].include?(team.id)
				errors.add(:player, "not playing in game")
			end
		end
end
