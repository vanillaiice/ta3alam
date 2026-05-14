class Teacher < ApplicationRecord
  validates :user_id, uniqueness: { scope: :klass_id }

  belongs_to :klass
  belongs_to :user

  scope :search, ->(q) {
    joins(:user)
      .where("users.name like :q or users.email_address like :q", q: "%#{q}%") if q.present?
  }
end
