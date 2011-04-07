class AddConnections < ActiveRecord::Migration
  def self.up
    create_table :connections do |t|
      t.integer :profile_id
      t.integer :to_profile_id

      t.timestamps
    end
  end

  def self.down
    drop_table :connections
  end
end
