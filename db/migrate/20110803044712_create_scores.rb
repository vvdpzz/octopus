class CreateScores < ActiveRecord::Migration
  def self.up
    create_table :scores do |t|
      t.references :user
      t.references :question
      t.references :answer
      
      t.integer :value
      t.string :remark

      t.timestamps
    end
  end

  def self.down
    drop_table :scores
  end
end
