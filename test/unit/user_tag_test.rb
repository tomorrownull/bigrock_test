require 'test_helper'

class UserTagTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "tagging" do
    one_user_tag = user_tags(:one)
    assert_equal taggings(:taggings_001) , one_user_tag.tagging
    assert_equal users(:one) , one_user_tag.user
  end
  test "destroy_user_tag" do
 
    new_tagging =Tagging.create(:tag=>tags(:tags_001),:taggable=>companies(:three))

    one_user_tag  = UserTag.create(:user=>users(:one),:tagging=>new_tagging)
    tag = one_user_tag.tagging.tag
    tagging = one_user_tag.tagging
    assert_not_nil Tagging.find_by_id(tagging)

    assert_not_nil tag
    assert_equal tag.taggings.size,4

    assert_equal tagging.user_tags.count,1
    one_user_tag.destroy
    assert_nil UserTag.find_by_id(one_user_tag)
    assert_nil Tagging.find_by_id(tagging)
    assert_equal tag.taggings.size,3
  end

end
