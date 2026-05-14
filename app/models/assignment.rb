class Assignment < ApplicationRecord
  belongs_to :klass
  belongs_to :user
  has_many :submissions, dependent: :destroy

  has_rich_text :description
  has_one_attached :file

  validates :title, presence: true
end
