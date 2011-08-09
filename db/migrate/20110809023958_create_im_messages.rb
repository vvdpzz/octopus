class CreateImMessages < ActiveRecord::Migration
  def self.up
    create_table :im_messages do |t|
      t.references :user
      t.references :question
      t.integer :im_group_id
      t.text :content
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :im_messages
  end
end
