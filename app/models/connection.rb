class Connection < ActiveRecord::Base
  belongs_to :profile
  belongs_to :to_profile, :class_name => "Profile"

  after_create :update_counts
  after_destroy :update_counts

  def connections_from
    connections.where("to_profile_id = ?", id)
  end

  def as_json(options=nil)
    {
      :title => to_profile.title,
      :location => to_profile.location,
      :lat => to_profile.lat,
      :lng => to_profile.lng
    }
  end

  def update_counts
    profile.update_attribute(:connected_to_count, profile.connections.count)
    to_profile.update_attribute(:connected_from_count, profile.connections_from.count)
  end

end
