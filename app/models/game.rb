# == Schema Information
#
# Table name: games
#
#  id              :integer         not null, primary key
#  away_team_id    :integer
#  home_team_id    :integer
#  away_runs       :integer         not null, default 0 
#  home_runs       :integer         not null, default 0
#  winner_id       :integer  
#  runs_updated_at :datetime
#  created_at      :datetime       
#  updated_at      :datetime
#

class Game < ApplicationRecord


  belongs_to :away_team, :class_name => 'Team', :foreign_key => 'away_team_id'
  belongs_to :home_team, :class_name => 'Team', :foreign_key => 'home_team_id'
  has_many :runs

  validate :teams_not_same

  after_save :update_team_wins

  def api_attributes
    attributes = {
      "id" => id,
      "home_team" => home_team,
      "away_team" => away_team,
      "winning_team_id" => winner_id,
      "home_team_runs" => home_runs,
      "away_team_runs" => away_runs,
      "runs_updated_at" => runs_updated_at,
      "created_at" => created_at,
      "updated_at" => updated_at

    }
  end
  def update_runs(team)
    if team == self.home_team
      self.home_runs += 1
    else
      self.away_runs += 1
    end
    update_winner
    self.save
  end

  def update_team_wins

    return if self.winner_id.nil?

    wins = Game.where("winner_id = #{self.winner_id}").count
    winner = Team.where("id = #{self.winner_id}").first
    winner.wins = wins
    winner.save
  end

  private
    def update_winner
      if self.home_runs > self.away_runs
        self.winner_id = self.home_team_id
      elsif self.home_runs < self.away_runs
        self.winner_id = self.away_team_id
      else
        self.winner_id = nil
      end
    end
    
    def teams_not_same
      if away_team_id == home_team_id
        errors.add(:home_team, "cannot play itself")
      end
    end
end
