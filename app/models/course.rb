class Course < ApplicationRecord
  include RichTextPresence

  validates :name, presence: true, uniqueness: true

  has_rich_text :description
  has_many :klasses, dependent: :destroy

  scope :search, ->(q) {
    left_joins(:rich_text_description)
      .where(
        "courses.name LIKE :q
         OR CAST(courses.number AS TEXT) LIKE :q
         OR action_text_rich_texts.body LIKE :q",
        q: "%#{q}%"
      )
      .distinct
  }
end
