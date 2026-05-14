require "test_helper"

class TeacherPolicyTest < ActiveSupport::TestCase
  setup do
    @users = {
      owner: users(:owner),
      teacher: users(:teacher),
      student: users(:student)
    }
    @teacher = teachers(:one)
    @teacher_other = teachers(:two)
    @teacher_from_another_klass = teachers(:three)
  end

  def test_scope
    @users.each do |role, user|
      assert TeacherPolicy::Scope.new(user, Teacher)
        .resolve.exists?(@teacher.id),
      should(role.to_s, "show")

      if role != :owner
        assert_not TeacherPolicy::Scope.new(user, Teacher)
          .resolve.exists?(@teacher_from_another_klass.id),
        should_not(role.to_s, "show")
      else
        assert TeacherPolicy::Scope.new(user, Teacher)
          .resolve.exists?(@teacher_from_another_klass.id),
        should(role.to_s, "show")
      end
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
        policy = TeacherPolicy.new(user, @teacher)

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
