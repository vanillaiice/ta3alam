require "test_helper"

class AssignmentTest < ActiveSupport::TestCase
  test "should not validate empty" do
    a = Assignment.new
    assert_not a.valid?
  end

  test "should not validate without title" do
    a = Assignment.new({
      klass: klasses(:one),
      user: users(:one)
    })
    assert_not a.valid?
  end

  test "should save" do
    a = Assignment.new({
      title: "assignment",
      klass: klasses(:one),
      user: users(:one)
    })
    assert a.save
  end
end
