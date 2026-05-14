class Klass < ApplicationRecord
  validates :code, presence: true, uniqueness: { scope: :course_id }

  belongs_to :course
  has_many :students, dependent: :destroy
  has_many :teachers, dependent: :destroy
  has_many :contents, dependent: :destroy
  has_many :assignments, dependent: :destroy
  has_many :announcements, dependent: :destroy

  scope :search, ->(q) {
    joins(:course)
      .where(
        "klasses.code like :q or cast(courses.number as text) like :q",
        q: "%#{q}%"
      )
  }
end
