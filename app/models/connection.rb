class Connection < ActiveRecord::Base
  belongs_to :profile
  belongs_to :to_profile, :class_name => "Profile"

  def as_json(options=nil)
    {
      :title => to_profile.title,
      :location => to_profile.location,
      :lat => to_profile.lat,
      :lng => to_profile.lng
    }
  end
end
