class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.references :user
      t.references :question
      
      t.boolean :anonymous, :default => false
      
      t.text :content

      t.string :username
      t.string :me
      
      t.binary :comment_a_json

      t.integer :created_at
      t.integer :updated_at
    end
  end

  def self.down
    drop_table :answers
  end
end
