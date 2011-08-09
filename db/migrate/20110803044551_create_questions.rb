class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.references :user
      
      t.integer :uuid
      
      t.string :title
      t.text :content
      t.string :realname
      
      t.boolean :anonymous, :default => false
      
      t.integer :credit,:default => 0
      t.float   :money, :default => 0.0
      t.datetime :expire_time
      
      t.integer :answers_count, :default => 0
      
      t.integer :accept_a_id, :default => 0
      t.string :status
      
      t.integer :created_at
      t.integer :updated_at
    end
  end

  def self.down
    drop_table :questions
  end
end
