# == Schema Information
#
# Table name: highlights
#
#  id                  :integer         not null, primary key
#  player_id           :integer
#  created_at          :datetime       
#  updated_at          :datetime
#  video_file_name     :string
#  video_content_type  :text
#  vide_file_size      :integer
#  video_uploaded_at   :datetime 
#

class Highlight < ApplicationRecord
	belongs_to :player
  
  has_attached_file :highlight
  # because curl is giving me issues with contnet type we are not validating, never do this in a production site
  do_not_validate_attachment_file_type :highlight
  #validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/
  #validates_attachment_file_name :media, matches: [/mp4\Z/, /avi\Z/]

  def api_attributes
    attributes = {
      "id" => id,
      "url" => highlight.url,
      "created_at" => created_at,
      "updated_at" => updated_at
    }
  end

  def self.concat_highlight(video)
  	player = video.player
    if player.highlight.nil?
      h = Highlight.new(:highlight => video.video )
      player.highlight = h
      player.highlight.save
      return
    end
  	update_string = "-i #{Rails.root}/public/#{player.highlight.highlight.path} -i #{Rails.root}/public/#{video.video.path} "
     # this just calls the construct_highlight method in a job rather that inline
  	#UpdateHilightVideoJob.perform_later(player.id, update_string)
    construct_highlight(player, update_string, 2)
  end

  def self.update_highlight(player)
    # reload the player before we update the highlight video to make sure we get an accurate video count
    player.reload
  	# destroy the old video and build it from the beging
    if player.highlight.nil?
      h = Highlight.new(:highlight => player.videos.first.video )
      player.highlight = h
      player.highlight.save
      return
    end
  	update_string = ''
  	player.videos.each do |video|
  		update_string << "-i #{Rails.root}/public/#{video.video.path} "
  	end
    # this just calls the construct_highlight method in a job rather that inline 
  	#UpdateHilightVideoJob.perform_later(videos.player.id, update_string)
    construct_highlight(player, update_string, videos.length)
  end

  def self.construct_highlight(player, update_string, input_files_count)
    # this is working with formatting speciffic videos
  	if system("ffmpeg #{update_string} -filter_complex \"[0:v:0] [0:a:0] [1:v:0] [1:a:0] concat=n=#{input_files_count}:v=1:a=1 [v] [a]\" -map \"[v]\" -map \"[a]\"  #{Rails.root}/public/highlight_#{player.id}.mp4")

      temp_video = File.open("#{Rails.root}/public/highlight_#{player.id}.mp4")
      #remove the old file, asign the new on
      player.highlight.highlight.destroy
      player.highlight.highlight = temp_video
      player.highlight.save

    	File.delete("#{Rails.root}/public/highlight_#{player.id}.mp4")
    end
  end

  private 
end

