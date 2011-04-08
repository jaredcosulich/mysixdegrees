class AddCounters < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.integer :photo_count
      t.integer :connected_to_count
      t.integer :connected_from_count
    end

    change_table :connections do |t|
      t.string  :reason
    end
  end

  def self.down
    change_table :profiles do |t|
      t.remove :photo_count
      t.remove :connected_to_count
      t.remove :connected_from_count
    end

    change_table :connections do |t|
      t.remove  :reason
    end
  end
end
