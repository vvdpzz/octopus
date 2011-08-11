class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :user
      t.integer :uuid, :limit => 5, :null=> false # uses MySQL bigint, stored in redis
      t.text :content
      t.text :excerpt
      t.integer :parent_id, :limit => 5, :null=> false # uses MySQL bigint, stored in redis
      t.integer :parent_uid, :limit => 5, :null=> false # uses MySQL bigint, stored in redis

      t.integer :created_at, :default => 0
      t.integer :updated_at, :default => 0
    end
  end

  def self.down
    drop_table :comments
  end
end
