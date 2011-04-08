class Connection < ActiveRecord::Base
  belongs_to :profile
  belongs_to :to_profile, :class_name => "Profile"

  after_create :update_counts
  after_destroy :update_counts

  def as_json(options=nil)
    {
      :id => id,
      :title => to_profile.title || "",
      :location => to_profile.location,
      :lat => to_profile.lat,
      :lng => to_profile.lng,
      :has_description => to_profile.description.present?,
      :photo_count => to_profile.photo_count,
      :connected_to_count => to_profile.connected_to_count
    }
  end

  def update_counts
    profile.update_attribute(:connected_to_count, profile.connections.count)
    to_profile.update_attribute(:connected_from_count, profile.connections_from.count)
  end

end
