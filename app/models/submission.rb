class Submission < ApplicationRecord
  belongs_to :assignment
  belongs_to :user

  has_rich_text :notes
  has_rich_text :feedback
  has_one_attached :submission_file
  has_one_attached :graded_submission_file

  validate :file_must_be_allowed_type

  private
    def file_must_be_allowed_type
    return unless submission_file.attached?
    return unless assignment&.accept_content_types.present?

    detected_type = submission_file.blob.content_type
    allowed_types = assignment.accept_content_types

    is_allowed = allowed_types.any? { |type| File.fnmatch?(type, detected_type) }

    unless is_allowed
      errors.add(
        :submission_file,
        "must be one of: #{allowed_types.reject(&:blank?).join(', ')}"
      )
    end
  end
end
