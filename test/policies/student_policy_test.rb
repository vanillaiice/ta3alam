require "test_helper"

class StudentPolicyTest < ActiveSupport::TestCase
  setup do
    @users = {
      owner: users(:owner),
      teacher: users(:teacher),
      student: users(:student)
    }
    @student = students(:one)
    @student_other = students(:two)
    @student_from_another_class = students(:three)
  end

  def test_scope
    @users.each do |role, user|
      assert StudentPolicy::Scope.new(user, Student)
        .resolve.exists?(@student.id),
      should(role.to_s, "show")

      if role != :owner
        assert_not StudentPolicy::Scope.new(user, Student)
          .resolve.exists?(@student_from_another_class.id),
        should_not(role.to_s, "show")
      else
        assert StudentPolicy::Scope.new(user, Student)
          .resolve.exists?(@student_from_another_class.id),
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
        policy = StudentPolicy.new(user, @student)

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
