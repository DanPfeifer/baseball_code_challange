# == Schema Information
#
# Table name: teams
#
#  id              :integer         not null, primary key
#  name            :text            not null
#  wins						 :integer					not null, default 0
#  created_at      :datetime       
#  updated_at      :datetime
#

class Team < ApplicationRecord

	validates_presence_of :name

  has_many :players
  has_many :runs
  has_many :games

  def self.ranks
  	teams = Team.all.order("wins DESC")
    teams_array = []
  	teams.each_with_index{ |team, index| teams_array << team.api_attributes(index + 1)}
    teams_array
  end
  def api_attributes(rank = nil)
  	attributes = {
  		"id" => id,
  		"name" => name,
  		"wins" => wins,
  		"rank" => rank,
  		"created_at" => created_at,
  		"updated_at" => updated_at
  	}

  end
end
