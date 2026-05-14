require "test_helper"

class AnnouncementPolicyTest < ActiveSupport::TestCase
  setup do
    @users = {
      owner: users(:owner),
      teacher: users(:teacher),
      student: users(:student)
    }
    @announcement = announcements(:one)
    @announcement_from_other_klass = announcements(:two)
  end

  def test_scope
    @users.each do |role, user|
      assert AnnouncementPolicy::Scope.new(user, Announcement).resolve.exists?(@announcement.id),
        should(role.to_s, "show")
    end

    assert AnnouncementPolicy::Scope.new(@users[:owner], Announcement).resolve.exists?(@announcement_from_other_klass.id),
      should("owner", "show")

    %i[ teacher student ].each do |role|
      user = @users[role]
      assert_not AnnouncementPolicy::Scope.new(user, Announcement).resolve.exists?(@announcement_from_other_klass.id),
        should_not(role.to_s, "show")
    end
  end

  {
    new?: %i[ teacher ],
    create?: %i[ teacher ],
    edit?: %i[ teacher ],
    update?: %i[ teacher ],
    destroy?: %i[ teacher owner ]
  }.each do |action, allowed_roles|
    define_method("test_#{action.to_s.delete('?')}") do
      @users.each do |role, user|
        policy = AnnouncementPolicy.new(user, @announcement)

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
        policy = AnnouncementPolicy.new(user, @announcement_from_other_klass)

        assert_not policy.public_send(action),
          should_not(role.to_s, action.to_s.delete("?"))
      end
    end
  end

  def test_destroy
    @users.each do |role, user|
      policy = AnnouncementPolicy.new(user, @announcement_from_other_klass)

      if role == :owner
        assert policy.destroy?, should("owner", "destroy")
      else
        assert_not policy.destroy?, should_not(role.to_s, "destroy")
      end
    end
  end
end
