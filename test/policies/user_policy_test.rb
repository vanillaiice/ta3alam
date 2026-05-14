require "test_helper"

class UserPolicyTest < ActiveSupport::TestCase
  setup do
    @users = {
      owner: users(:owner),
      teacher: users(:teacher),
      student: users(:student)
    }
    @user = users(:student_one)
  end

  def test_scope
    assert UserPolicy::Scope.new(users(:owner), User)
      .resolve.exists?(@user.id),
    should("owner", "show")

    %i[ teacher student ].each do |role|
      assert_not UserPolicy::Scope.new(users(role), User)
        .resolve.exists?(@user.id),
      should_not(role.to_s, "show")
    end
  end

  {
    new?: %i[ owner ],
    create?: %i[ owner ],
    edit?: %i[ owner ],
    update?: %i[ owner ],
    destroy?: %i[ owner ]
  }.each do |action, allowed_roles|
    define_method("test_#{action.to_s.delete('?')}") do
      @users.each do |role, user|
        policy = UserPolicy.new(user, @content)

        if allowed_roles.include?(role)
          assert policy.public_send(action),
            should(role.to_s, action.to_s.delete("?"))
        else
          assert_not policy.public_send(action),
            should_not(role.to_s, action.to_s.delete("?"))
        end
      end
    end
  end
end
