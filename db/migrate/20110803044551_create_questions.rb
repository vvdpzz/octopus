class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.references :user, :null => false
      t.integer :uuid, :limit => 5, :null=> false
      
      t.string :title, :null => false
      t.text :content
      
      t.boolean :anonymous, :default => false
      
      t.integer :credit,:default => 0
      t.float   :money, :default => 0.0
      
      t.integer :answer_count, :default => 0
      t.integer :vote_count, :default => 0
      t.integer :view_count, :default => 1
      
      t.integer :accept_a_id, :default => 0
      t.string :status, :default => 'normal'
      
      t.integer :expire_time, :default => 0
      t.integer :created_at, :default => 0
      t.integer :updated_at, :default => 0
    end
  end

  def self.down
    drop_table :questions
  end
end
