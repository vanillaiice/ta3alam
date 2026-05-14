require "test_helper"

class SubmissionPolicyTest < ActiveSupport::TestCase
  setup do
    @users = {
      owner: users(:owner),
      teacher: users(:teacher),
      student: users(:student)
    }
    @submission = submissions(:one)
    @submission_from_other_klass = submissions(:two)
  end

  def test_scope
    @users.each do |role, user|
      assert SubmissionPolicy::Scope.new(user, Submission).resolve.exists?(@submission.id),
        should(role.to_s, "show")
    end

    assert SubmissionPolicy::Scope.new(@users[:owner], Submission).resolve.exists?(@submission_from_other_klass.id),
      should("owner", "show")

    %i[ teacher student ].each do |role|
      user = @users[role]
      assert_not SubmissionPolicy::Scope.new(user, Submission).resolve.exists?(@submission_from_other_klass.id),
        should_not(role.to_s, "show")
    end
  end

  {
    new?: %i[ student ],
    create?: %i[ student ],
    edit?: %i[ teacher ],
    update?: %i[ teacher ],
    destroy?: %i[ owner ]
  }.each do |action, allowed_roles|
    define_method("test_#{action.to_s.delete('?')}") do
      @users.each do |role, user|
        policy = SubmissionPolicy.new(user, @submission)

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

  %i[new? create? edit? update?].each do |action|
    define_method("test_#{action.to_s.delete('?')}") do
      @users.each do |role, user|
        policy = SubmissionPolicy.new(user, @submission_from_other_klass)

        assert_not policy.public_send(action),
          should_not(role.to_s, action.to_s.delete("?"))
      end
    end
  end

  def test_destroy
    @users.each do |role, user|
      policy = SubmissionPolicy.new(user, @submission_from_other_klass)

      if role == :owner
        assert policy.destroy?, should("owner", "destroy")
      else
        assert_not policy.destroy?, should_not(role.to_s, "destroy")
      end
    end
  end
end
