require "test_helper"

class SubmissionTest < ActiveSupport::TestCase
  test "should not validate empty" do
    s = Submission.new
    assert_not s.valid?
  end

  test "should save without file" do
    s = Submission.new({
      assignment: assignments(:one),
      user: users(:student)
    })

    assert s.save
  end

  test "should not validate with invalid content type" do
    s = Submission.new({
      assignment: assignments(:one),
      user: users(:student)
    })

    s.submission_file.attach(
      io: File.open(
        Rails.root.join("test/fixtures/files/submission.pdf")
      ),
      filename: "submission.pdf",
      content_type: "application/pdf"
    )

    assert_not s.valid?
  end

  test "should save with file" do
    s = Submission.new({
      assignment: assignments(:one),
      user: users(:student)
    })

    s.submission_file.attach(
      io: File.open(
        Rails.root.join("test/fixtures/files/submission.txt")
      ),
      filename: "submission.txt",
      content_type: "text/plain"
    )

    assert s.save
  end
end
