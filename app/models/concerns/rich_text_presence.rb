module RichTextPresence
  extend ActiveSupport::Concern

  class_methods do
    def validates_rich_text_presence_of(*attrs)
      attrs.each do |attr|
        validate do
          rich_text = send(attr)

          if rich_text.blank? || rich_text.body.blank?
            errors.add(attr, "cannot be empty")
          end
        end
      end
    end
  end
end
