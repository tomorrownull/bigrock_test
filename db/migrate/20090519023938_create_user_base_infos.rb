class CreateUserBaseInfos < ActiveRecord::Migration
  def self.up
    create_table :user_register_infos do |t|
      t.string :nick_name,:null => false,:default=>"马甲"
      t.string :email,:null => false
      t.string :password,:null => false
      t.string  :title,:default=>""

      t.boolean :IsActive,   :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :user_register_infos
  end
end
