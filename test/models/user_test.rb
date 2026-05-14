require "test_helper"

class UserTest < ActiveSupport::TestCase
  REQUIRED_ATTRS = {
    email_address: "email@email.com",
    name: "user",
    password: "password",
    role: :owner
  }

  VALID_ROLES = %i[ admin owner teacher student ]

  test "should not validate empty user" do
    u = User.new
    assert_not u.valid?
  end

  REQUIRED_ATTRS.each_key do |missing|
    test "should not validate when #{missing} is missing" do
      attrs = REQUIRED_ATTRS.except(missing)
      u = User.new(attrs)
      assert_not u.valid?, "User saved without #{missing}"
    end
  end

  User.roles.keys.each do |role|
    test "can validate user when role is #{role}" do
      u = User.new({
        email_address: "email@email.com",
        name: "user",
        password: "password",
        role: role
      })
      assert u.valid?, "Expected user with role #{role} to be valid"
    end
  end

  test "should not save when role is invalid" do
    assert_raises ArgumentError do
      User.new({
        email_address: "email@email.com",
        name: "user",
        password: "password",
        role: :dev
      })
    end
  end
end
