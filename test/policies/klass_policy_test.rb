require "test_helper"

class KlassPolicyTest < ActiveSupport::TestCase
  setup do
    @users = {
      owner: users(:owner),
      teacher: users(:teacher),
      student: users(:student)
    }
    @klass = klasses(:one)
  end

  def test_scope
    @users.each do |role, user|
      assert KlassPolicy::Scope.new(user, Klass).resolve.exists?(@klass.id),
        should(role.to_s, "show")
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
        policy = KlassPolicy.new(user, @klass)

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
