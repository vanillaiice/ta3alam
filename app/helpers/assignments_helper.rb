module AssignmentsHelper
  def format_timestamp(assignment)
    deadline_class, deadline_text, exact_deadline =
      if assignment.deadline.past?
        [ "text-red-600 font-semibold",
         "Past due",
         l(assignment.deadline, format: :long) ]
      elsif assignment.deadline < 3.days.from_now
        [ "text-orange-600 font-semibold",
         "#{distance_of_time_in_words(Time.current, assignment.deadline)} left",
         l(assignment.deadline, format: :long) ]
      else
        [ "text-green-600",
         "#{distance_of_time_in_words(Time.current, assignment.deadline)} left",
         l(assignment.deadline, format: :long) ]
      end

    uploaded_text =
      if assignment.created_at > 7.days.ago
        "#{time_ago_in_words(assignment.created_at)} ago (#{exact_deadline})"
      else
        l(assignment.created_at, format: :long)
      end

    content_tag(:div, class: "text-sm space-y-1") do
      concat content_tag(:p, "Uploaded: #{uploaded_text}", class: "text-gray-600")
      concat content_tag(:p, "Deadline: #{deadline_text}", class: deadline_class)
    end
  end

  def accepted_types_badges(assignment)
    return unless assignment.accept_content_types.present?

    friendly = {
      "application/pdf" => "PDF",
      "application/zip" => "ZIP",
      "text/plain" => "Text",
      "image/png" => "PNG",
      "image/jpeg" => "JPEG",
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" => "DOCX",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" => "XLSX",
      "audio/*" => "Audio",
      "audio/mpeg" => "MP3",
      "audio/wav" => "WAV",
      "audio/ogg" => "OGG",
      "audio/webm" => "WEBM"
    }

    safe_join(
      assignment.accept_content_types.compact.reject(&:blank?).map do |type|
        label = friendly[type] || type.to_s.split("/").last.to_s.upcase
        tag.span(label, class: "badge badge-neutral")
      end,
      " "
    )
  end
end
