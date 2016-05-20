# == Schema Information
#
# Table name: players
#
#  id              :integer         not null, primary key
#  name            :text
#  team_id         :integer
#  runs_count       :integer         not null, default 0 
#  created_at      :datetime       
#  updated_at      :datetime
#

class Player < ApplicationRecord

  validates_presence_of :name

  belongs_to :team
  has_many :videos, :dependent => :destroy
  has_many :images, :dependent => :destroy
  has_many :runs, :dependent => :destroy
  has_one :highlight, :dependent => :destroy

  def api_attributes
  	attributes ={
  		"id" => id,
  		"name" => name,
  		"team" => team,
  		"runs" => runs_count,
  		"created_at" => created_at,
  		"updated_at" => updated_at
  	}
    if highlight
      attributes["highlight"] =  highlight.api_attributes
    end
    attributes
  end
  private
  
end
