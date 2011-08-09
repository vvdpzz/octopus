class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|

      t.integer :message_id # we need to keep this coulmn for keeping the IM message structure, like google does 
      t.integer :sender_id
      t.integer :receiver_id
      
      t.string :content

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
