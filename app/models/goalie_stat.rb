# == Schema Information
#
# Table name: goalie_stats
#
#  id              :integer          not null, primary key
#  player_id       :integer
#  game_id         :integer
#  verdict         :integer
#  goals_against   :integer
#  shots_against   :integer
#  saves           :integer
#  save_percentage :decimal(5, 2)
#  shutout         :boolean
#  pim             :integer
#  toi             :integer
#
# Indexes
#
#  index_goalie_stats_on_game_id    (game_id)
#  index_goalie_stats_on_player_id  (player_id)
#

class GoalieStat < ActiveRecord::Base
	extend EnumerateIt

	## Relationships
	belongs_to :player
	belongs_to :team
	belongs_to :opponent, class_name: 'Team'

	has_enumeration_for :verdict, with: Enums::GoalieRecord

	## Scopes
	scope :vs, lambda { |opp| where(opponent_id: opp) }
	scope :outcome, lambda { |dec| where(decision: dec) }
end
