require "test_helper"

class AnnouncementTest < ActiveSupport::TestCase
  test "should not validate empty" do
    a = Announcement.new
    assert_not a.valid?
  end

  test "should not validate without content" do
    a = Announcement.new({
      klass: klasses(:one),
      user: users(:one)
    })
    assert_not a.valid?
  end

  test "should save" do
    a = Announcement.new({
      klass: klasses(:one),
      user: users(:one)
    })
    a.content = "content"
    assert a.save
  end
end
