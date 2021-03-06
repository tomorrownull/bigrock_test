require 'test_helper'

class UserSettingTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "can_visibility" do
    user_one = users(:one)
    user_two = users(:two)
    user_three = users(:three)

    user_setting = user_settings(:two)
    #都能看到
    assert user_setting.can_visibility?("img_visibility", user_three)
    assert user_setting.can_visibility?("img_visibility", user_two)
    #只有好友能看到
    user_setting.img_visibility = UserSetting::VISIBILITY_TYPES[1]
    user_setting.save
#    assert !user_setting.can_visibility?("img_visibility", user_three)
    assert user_setting.can_visibility?("img_visibility", user_one)
    assert user_setting.can_visibility?("img_visibility", user_two)
    #只有自己能看到
    user_setting.img_visibility = UserSetting::VISIBILITY_TYPES[2]
    user_setting.save
    
#    assert !user_setting.can_visibility?("img_visibility", user_three)
#    assert !user_setting.can_visibility?("img_visibility", user_one)
    assert user_setting.can_visibility?("img_visibility", user_two)

  end
end
