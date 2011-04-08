class Photo < ActiveRecord::Base
  belongs_to :profile

  has_attached_file :image,
    PAPERCLIP_STORAGE_OPTIONS.merge(
    :styles => { :large => "600x600", :preview => "60x60" },
    :default_style => :preview  ,
    :default_url => "/images/loading.gif"
    )

  after_create :update_counts
  after_destroy :update_counts

  def update_counts
    profile.update_attribute(:photo_count, profile.photos.count)
  end
end
