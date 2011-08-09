class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.references :user
      t.column     "q_id", :integer, :limit => 5, :null=> false # uses MySQL bigint, stored in redis
      t.string     :title
      t.text       :content
      t.string     :username
      t.string     :userid
      t.boolean    :anonymous   , :default => false
      t.integer    :credit      , :default => 0
      t.float      :money       , :default => 0.00
      t.datetime   :expire_time
      t.string     :status

      t.integer    :created_at
      t.integer    :updated_at
      
      #t.string :follower_id_list #Make it into Redis, and use link table to show the relationship 
      #t.string :answer_id_list   #Make it into Redis, and use link table to show the relationship 
      #t.integer :accept_a_id     #Make it into Redis, and use link table to show the relationship
      #t.column :comment_q_json, :binary, :limit => 10.megabyte #Make it into Redis, and use link table to show the relationship
      #comment_qjson 字 段 存 储 示 例
      #{"id": "71f0c4d2291844cca2df6f486e96e37c",
      #  "user_id": "f48b0440ca0c4f66991c4d5f6a078eaf",
      #  "question_id": "f48b0440ca0c4f66991c4d5f6a078eaf",
      #  "content": u"here is my comment",
      #  "url": "http://luexiao.com/ 群 组/ 类 别/71f0c4d2-2918-44cc-a2df-6f486e96e37c",
      #  "published": 1235697046,
      #  "updated": 1235697046,}
      
      #column for editing question
      # t.string  :update_uid_list
      # t.string  :update_uname_list
      # t.string  :update_time_list




    end
  end

  def self.down
    drop_table :questions
  end
end
