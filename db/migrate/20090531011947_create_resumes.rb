require 'action_view/helpers/asset_tag_helper'

class CreateResumes < ActiveRecord::Migration
  def self.up
    create_table :resumes do |t|
      t.string  :name
      t.string  :type_name,:limit=>18
      t.integer :user_id
      t.string  :user_name,:limit=>18
      t.date    :birthday
      t.boolean :sex
      t.string  :address
      t.string  :phone1
      t.string  :phone2
      t.string  :phone3
      t.string  :phone4
      t.string  :website1
      t.string  :website2
      t.string  :website3
      t.string  :website4
      t.text  :self_description
      t.string  :goal
      t.string  :interests
      t.string  :qq
      t.string  :msn
      t.string  :city
      t.string  :industry
      t.string  :state
      t.boolean :is_current,:default=>false
      t.timestamps
    end
  end

  def self.down
    drop_table :resumes
  end
end
