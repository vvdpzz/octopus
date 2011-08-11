class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.references :user
      t.references :question
      
      t.integer :uuid, :limit => 5, :null=> false # uses MySQL bigint, stored in redis
      t.boolean :anonymous, :default => false
      
      t.text :content
      
      t.integer :vote_count, :default => 0
      t.boolean :is_correct, :default => false # 是 否 是 正 确 答 案
      t.integer :quid
      t.integer :created_at, :default => 0
      t.integer :updated_at, :default => 0
      #t.column :comment_a_json, :binary, :limit => 10.megabyte #Make it into Redis, and use link table to show the relationship
      #comment_a_json 字 段 存 储 示 例
      #{"id": "71f0c4d2291844cca2df6f486e96e37c",
      #  "user_id": "f48b0440ca0c4f66991c4d5f6a078eaf",
      #  "question_id": "f48b0440ca0c4f66991c4d5f6a078eaf",
      #  "answer_id": "f48b0440ca0c4f66991c4d5f6a078eaf",
      #  "content": u"here is my comment",
      #  "url": "http://luexiao.com/ 群 组/ 类 别/71f0c4d2-2918-44cc-a2df-6f486e96e37c",
      #  "published": 1235697046,
      #  "updated": 1235697046,}
    end
  end

  def self.down
    drop_table :answers
  end
end
