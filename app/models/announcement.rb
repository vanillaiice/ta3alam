class Announcement < ApplicationRecord
  include RichTextPresence

  belongs_to :klass
  belongs_to :user
  has_rich_text :content

  validates_rich_text_presence_of :content
end
