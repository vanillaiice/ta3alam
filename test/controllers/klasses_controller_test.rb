require "test_helper"

class KlassesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @klass = klasses(:one)
    sign_in(users(:owner))
  end

  test "should get index" do
    get klasses_url
    assert_response :success
  end

  test "should get show" do
    get klass_url(@klass)
    assert_response :success
  end

  test "should get new" do
    get new_klass_url
    assert_response :success
  end

  test "should get edit" do
    get edit_klass_url(@klass)
    assert_response :success
  end
end
