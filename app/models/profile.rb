class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :connections
  has_many :photos

  after_create :assign_slug

  def connections_from
    connections.where("to_profile_id = ?", id)
  end
  
  def to_param
    slug
  end

  def assign_slug
    update_attributes(:slug => id.to_obfuscated.insert(1, Integer::ENCODE_CHARS[rand(Integer::ENCODE_CHARS.length)]))
  end

  def name
    title || "Someone"
  end
end
