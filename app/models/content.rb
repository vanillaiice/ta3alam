class Content < ApplicationRecord
  belongs_to :klass
  belongs_to :user

  has_rich_text :description

  has_one_attached :file

  validate :file_must_be_attached, on: :create

  def file_must_be_attached
    errors.add(:file, "must be attached") unless file.attached?
  end
end
