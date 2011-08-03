class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.references :user
      
      t.string :title
      t.text :content
      
      t.string :answer_id_list
      
      t.binary :comment_q_json
      
      t.string :follower_id_list      

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
