class Student < ApplicationRecord
  validates :user_id, uniqueness: { scope: :klass_id }

  belongs_to :user
  belongs_to :klass

  scope :search, ->(q) {
    joins(:user)
      .where("users.name like :q or users.email_address like :q", q: "%#{q}%") if q.present?
  }
end
