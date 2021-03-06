require 'test_helper'

class AttachmentTest < ActiveSupport::TestCase

  test "company_icon" do
    company_icon = CompanyIcon.new(:uploaded_data=>test_uploaded_file("sorry.jpg","image/jpg"))

    company_one = Company.find(1)
    company_one.icon =  company_icon 
    assert company_one.icon_file_path().to_s.index("sorry.jpg")>0
    
  end

  test "user_icon" do
    user_icon = UserIcon.new(:uploaded_data=>test_uploaded_file("sorry.jpg","image/jpg"))
    user_one = User.find(1)
    user_one.icon =  user_icon
    assert user_one.icon_file_path().to_s.index("sorry.jpg")>0

  end
  #测试 超过时间没有处理临时文件
  test "temp_icon" do
    UserIcon.destroy_all()
    
    user_icon = UserIcon.new(:uploaded_data=>test_uploaded_file("sorry.jpg","image/jpg"),:created_at=>6.minutes.ago)

    user_icon.save
    user_icon.thumbnails[0].update_attribute("created_at", 6.minutes.ago)

    user_icon = UserIcon.new(:uploaded_data=>test_uploaded_file("sorry.jpg","image/jpg"))
    user_one = User.find(1)
    user_one.icon =  user_icon
    assert user_one.icon_file_path().to_s.index("sorry.jpg")>0
    user_one.save()
 
#    assert_equal  2,UserIcon.find(:all).size


  end
end
