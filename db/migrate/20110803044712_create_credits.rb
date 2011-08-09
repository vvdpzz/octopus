class CreateCredits < ActiveRecord::Migration
  def self.up
    create_table :credits do |t|
      t.references :user
      t.references :question
      t.references :answer
      
      t.integer :value, :null => false
      t.string :remark, :default => '' # 如 果 需 要 修 改 请 加 入 解 释 以 及 修 改 时 间 用 逗 号 分 隔

      t.timestamps
    end
  end

  def self.down
    drop_table :credits
  end
end
