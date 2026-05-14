require "test_helper"

class ContentTest < ActiveSupport::TestCase
  test "should not validate empty" do
    c = Content.new
    assert_not c.valid?
  end

  test "should not save with no file attached" do
    c = Content.new({
      klass: klasses(:one),
      user: users(:one)
    })

    assert_not c.save
  end

  test "should save" do
    c = Content.new({
      klass: klasses(:one),
      user: users(:one)
    })

    c.file.attach(
      io: File.open(
        Rails.root.join("test/fixtures/files/content.txt")
      ),
      filename: "content.txt",
      content_type: "text/plain"
    )

    assert c.save
  end
end
