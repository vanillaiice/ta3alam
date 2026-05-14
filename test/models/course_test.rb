require "test_helper"

class CourseTest < ActiveSupport::TestCase
  test "should not validate empty course" do
    c = Course.new
    assert_not c.valid?
  end

  test "should not validate course with non unique name" do
    c = Course.new({
      name: "course",
      description: "description"
    })
    assert c.save

    c = Course.new({
      name: "course",
      description: "description"
    })
    assert_not c.valid?
  end

  test "should save" do
    c = Course.new({
      name: "course",
      description: "description"
    })
    assert c.save
  end
end
