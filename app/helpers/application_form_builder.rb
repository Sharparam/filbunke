# frozen_string_literal: true

class ApplicationFormBuilder < ActionView::Helpers::FormBuilder
  def error_messages(options = {})
    @template.error_messages_for(@object, options)
  end
end
