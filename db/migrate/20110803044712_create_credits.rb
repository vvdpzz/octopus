class CreateCredits < ActiveRecord::Migration
  def self.up
    create_table :credits do |t|
      t.references :user
      t.references :question
      t.references :answer
      
      t.integer :value
      t.string :remark

      t.timestamps
    end
  end

  def self.down
    drop_table :credits
  end
end
