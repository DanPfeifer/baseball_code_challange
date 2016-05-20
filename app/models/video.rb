# == Schema Information
#
# Table name: videos
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

class Video < ApplicationRecord
  belongs_to :player
  
  has_attached_file :video
  # because curl is giving me issues with contnet type we are not validating, never do this in a production site
  do_not_validate_attachment_file_type :video, :styles => {
      :mp4video => { :geometry => '520x390', :format => 'mp4',
        :convert_options => { :output => { :vcodec => 'libx264',
          :vpre => 'ipod640', :b => '250k', :bt => '50k',
          :acodec => 'libfaac', :ab => '56k', :ac => 2 } } },
       :preview => { :geometry => '300x300>', :format => 'jpg', :time => 5 }
    },
    processors: [:ffmpeg]
    
  #validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/
  #validates_attachment_file_name :media, matches: [/mp4\Z/, /avi\Z/]

  after_save :concat_highlight
  after_update :update_highlight
  #after_destroy :update_highlight

  def api_attributes
    attributes = {
      "id" => id,
      "url" => video.url,
      "created_at" => created_at,
      "updated_at" => updated_at
    }
  end

  private 

    def concat_highlight
      Highlight.concat_highlight(self)
    end

    def update_highlight
      Highlight.update_highlight(self.player)
    end

end
