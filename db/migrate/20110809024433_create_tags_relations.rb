class CreateTagsRelations < ActiveRecord::Migration
  def self.up
    create_table :tags_relations do |t|
      t.column "tag_id_1", :integer, :limit => 5, :null=> false # uses MySQL bigint, stored in redis
      t.column "tag_id_2", :integer, :limit => 5, :null=> false # uses MySQL bigint, stored in redis
      t.boolean :father
      t.boolean :brother
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :tags_relations
  end
end
