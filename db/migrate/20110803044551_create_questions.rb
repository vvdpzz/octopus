class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.references :user
      
      t.string :title
      t.text :content
      t.string :username
      
      t.boolean :anonymous, :default => false
      
      t.integer :credit,:default => 0
      t.float   :money, :default => 0.00
      t.datetime :expire_time
      
      t.string :answer_id_list
      t.integer :accept_a_id
      t.string :status
      
      t.binary :comment_q_json
      
      t.string :follower_id_list      

      t.integer :created_at
      t.integer :updated_at
    end
  end

  def self.down
    drop_table :questions
  end
end
