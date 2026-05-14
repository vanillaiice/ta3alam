require "test_helper"

class SettingPolicyTest < ActiveSupport::TestCase
  setup do
    @users = {
      owner: users(:owner),
      teacher: users(:teacher),
      student: users(:student)
    }
    @setting = settings(:one)
  end

  def test_scope
    owner = @users[:owner]
    assert SettingPolicy::Scope.new(owner, Setting).resolve.exists?(@setting.id),
      should(owner.role.to_s, "show")

    [ :teacher, :student ].each do |role|
      user = @users[role]
      assert_not SettingPolicy::Scope.new(user, Setting).resolve.exists?(@setting.id),
        should_not(user.role.to_s, "show")
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
        policy = SettingPolicy.new(user, @setting)

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
