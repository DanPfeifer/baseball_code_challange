# == Schema Information
#
# Table name: images
#
#  id                  :integer         not null, primary key
#  player_id           :integer
#  created_at          :datetime       
#  updated_at          :datetime
#  image_file_name     :string
#  image_content_type  :text
#  image_file_size      :integer
#  image_uploaded_at   :datetime 
#


class Image < ApplicationRecord
  belongs_to :player

  has_attached_file :image 
  # because curl is giving me issues with contnet type we are not validating, never do this in a production site
  do_not_validate_attachment_file_type :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  #validates_attachment_content_type :media, content_type: /\Aimage\/.*\Z/
  #validates_attachment_file_name :media, matches: [/png\Z/, /jpe?g\Z/]

  before_update :destroy_image

  def api_attributes
    attributes = {
      "id" => id,
      "url" => image.url,
      "created_at" => created_at,
      "updated_at" => updated_at
    }
  end
  private 
    def destroy_image
      self.image.destroy
    end

end
