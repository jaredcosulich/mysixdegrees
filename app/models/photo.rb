class Photo < ActiveRecord::Base
  belongs_to :profile

  has_attached_file :image,
    PAPERCLIP_STORAGE_OPTIONS.merge(
    :styles => { :large => "600x600", :preview => "60x60" },
    :default_style => :preview  ,
    :default_url => "/images/loading.gif"
    )
end
