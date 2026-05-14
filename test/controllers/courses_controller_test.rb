require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @klass = klasses(:one)
    sign_in(users(:owner))
  end

  test "should get index" do
    get courses_url
    assert_response :success
  end
end
