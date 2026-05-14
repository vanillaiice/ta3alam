require "test_helper"

class KlassTest < ActiveSupport::TestCase
  test "should not validate empty" do
    k = Klass.new
    assert_not k.valid?
  end

  test "should not validate klass with non unique code and course" do
    k = Klass.new({
      code: "code",
      course: courses(:one)
    })
    assert k.save

    k = Klass.new({
      code: "code",
      course: courses(:one)
    })
    assert_not k.valid?
  end

  test "should save" do
    k = Klass.new({
      code: "code",
      course: courses(:one)
    })
    assert k.save
  end
end
