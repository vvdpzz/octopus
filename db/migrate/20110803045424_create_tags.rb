class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|

       t.column "t_id", :integer, :limit => 5, :null=> false # uses MySQL bigint, stored in redis
       t.string :name, :null => false
       t.integer :area_id, :null => false #format is 00, eg: 01 => 'computing'
       t.string :area_name, :null => false
       t.integer :group_id, :null => false, :default => '000' #000 means this is a recored for area, format is 000, eg: 001 => 'programming language'
       t.string :group_name, :null => false
       t.integer :question_count, :null => false, :default => '0'  # 缓 存 有 多 少 问 题 属 于 这 个tag
       t.integer :follower_count, :null => false, :default => '0' # 缓 存 有 多 少 人 关 注 这 个tag
       
       t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end
