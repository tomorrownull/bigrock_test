require 'test_helper'

class PassTest < ActiveSupport::TestCase
  test "destroy" do
    
  end
  # Replace this with your real tests.
  test "sub_work_item" do  
    passes_one = passes(:one)
    work_item= WorkItem.new()
    work_item.name="sjtu"
    work_item.work_description="description"
    work_item.work_content ="content"
    passes_one.work_items<<work_item
    passes_one.save()
    assert_not_nil passes_one.work_items.find(work_item)
  end
  test "sub_judge" do
    passes_one = passes(:one)
    passes_one.judges_count = 0
    passes_one.save
    judge= Judge.new()
    judge.ability_value =4
    judge.eq_value = 3
    judge.creditability_value =5
    judge.description ="表现不错"
    passes_one.judges << judge
    passes_one.reload() 
    assert_not_nil passes_one.judges.find(judge)
    assert_equal 1, passes_one.judges_count
    
    passes_one.reload()
    assert_equal passes_one.ability_value,judge.ability_value
    assert_equal passes_one.eq_value,judge.eq_value
    assert_equal passes_one.creditability_value,judge.creditability_value

    judge.ability_value =1
    judge.eq_value = 2

    judge.save
    passes_one.reload()
    assert_equal passes_one.ability_value,1
    assert_equal passes_one.eq_value,2
    assert_equal passes_one.creditability_value,5
    
    judge.destroy
    passes_one.reload()
    assert_equal passes_one.ability_value,0
    assert_equal passes_one.eq_value,0
    assert_equal passes_one.creditability_value,0
 
  end

  #平均值
  test "average_judge" do
    passes_one = passes(:one)
    passes_one.judges.clear
    judge= Judge.new()
    judge.ability_value =4
    judge.eq_value = 3
    judge.creditability_value =5
    judge.description ="表现不错"
    passes_one.judges << judge

    assert_not_nil passes_one.judges.find(judge)
    assert_equal 4,passes_one.average_judge("ability_value")
    assert_equal 3,passes_one.average_judge("eq_value")
    assert_equal 5,passes_one.average_judge("creditability_value")

  end
  test "judge_star" do
    passes_one = passes(:one)
    passes_one.judges.clear
    judge= Judge.new()
    judge.ability_value =4
    judge.eq_value = 3
    judge.creditability_value =5
    judge.description ="表现不错"
    passes_one.judges << judge

    assert_not_nil passes_one.judges.find(judge)
    assert_equal 1,passes_one.judge_count_by_star("ability_value",4)
    assert_equal 0,passes_one.judge_count_by_star("ability_value",1)

    assert_equal 1,passes_one.judge_count_by_star("eq_value",3)
    assert_equal 0,passes_one.judge_count_by_star("eq_value",1)

    assert_equal 1,passes_one.judge_count_by_star("creditability_value",5)
    assert_equal 0,passes_one.judge_count_by_star("creditability_value",1)
  end

  test "is_yokemate" do
    passes_one = passes(:one)
    assert passes_one.yokemate?(users(:two))
  end
  test "yokemates" do
    passes_one = passes(:one)
    assert_equal 1, passes_one.yokemates.size
    user_three = users(:three)
    user_three.current_resume.passes << Pass.new(:user_id=>3,:company_id=>1,:begin_date=> "2009-06-01",:is_current=>true)
 
    assert_equal 2, passes_one.yokemates.size
    user_three.destroy
    assert_equal 1, passes_one.yokemates.size
  end
  test "available_yokemates" do
    passes_one = passes(:one)
    assert_equal passes_one.yokemates.size, passes_one.available_yokemates.size

    judge= Judge.new()
    judge.ability_value =4
    judge.eq_value = 3
    judge.creditability_value =5
    judge.description ="表现不错"
    judge.judger_id =2
    judge.user= passes_one.user
    passes_one.judges << judge
    passes_one.reload
    assert_equal 0, passes_one.available_yokemates.size
  end
 
end
