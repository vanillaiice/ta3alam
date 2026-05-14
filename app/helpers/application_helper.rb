module ApplicationHelper
  def show_if(*roles, &block)
    return unless Current.user
    return unless roles.any? { |role| Current.user.public_send("#{role}?") }
    capture(&block)
  end

  def mi(name, outlined: false, size: 24, extra_classes: "")
    style = outlined ? "material-icons-outlined" : "material-icons"
    classes = "#{style} #{extra_classes}".strip

    content_tag(:i, name.to_s, class: classes, style: "font-size: #{size}px;")
  end

  def btn_link(path, text, icon: nil, outlined: false, size: 24, classes: "")
    actual_path = path.is_a?(Array) || path.is_a?(ActiveRecord::Base) ? polymorphic_path(path) : path

    tag.a href: actual_path, class: [ "btn", classes ].join(" ") do
      safe_join([
        (mi(icon, outlined: outlined, size: size) if icon),
        (tag.span(text) if text)
      ].compact)
    end
  end

  def nav_link_to(name, path, **options)
    current = request.path.starts_with?(path)
    classes = [ "link", "link-hover", "options[:class]" ]
    classes << "underline font-semibold" if current
    link_to(name, path, options.merge(class: classes.compact.join(" ")))
  end

  def render_content(file, options = {})
    return unless file.attached?

    content_type = file.content_type

    case
    when content_type.start_with?("video/")
      video_tag url_for(file), { controls: true, width: "640" }.merge(options)

    when content_type.start_with?("audio/")
      audio_tag url_for(file), { controls: true }.merge(options)

    when content_type == "application/pdf"
      content_tag(:embed, "", src: url_for(file), type: "application/pdf",
                  width: "100%", height: "600px")

    when content_type.start_with?("image/")
      image_tag url_for(file), { alt: file.filename.to_s, class: "max-w-full h-auto" }.merge(options)

    when content_type == "text/plain"
      # Reads the file’s text. Limit length to avoid dumping huge files.
      text = file.download.force_encoding("UTF-8")
      snippet = text.length > 2000 ? "#{text[0..2000]}..." : text
      content_tag(:pre, snippet, class: "whitespace-pre-wrap p-2 rounded")

    else
      link_to "Download file", url_for(file),
        target: "_blank", rel: "noopener", class: "link link-hover"
    end
  end
end
