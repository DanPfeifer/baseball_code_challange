class UpdateHilightVideoJob < ApplicationJob
  queue_as :urgent

  def perform(player_id, update_string)
    # Do something later
    player = Player.find_by_id(player_id)
    if player.present?
    	Highlight.construct_highlight(player, update_string)
    end
  end
end
