class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.references :user
      
      t.string :asked_id_list
      t.string :subscribe_id_list
      t.string :collected_id_list
      t.string :follower_uid_list
      t.string :following_uid_list

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
