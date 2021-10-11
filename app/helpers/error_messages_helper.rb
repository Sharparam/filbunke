# frozen_string_literal: true

module ErrorMessagesHelper
  def error_messages_for(*args)
    options, model, error_count = parse_args args

    title = extract_title options, model, extract_action(options), error_count
    message = extract_message options
    messages = extract_messages args

    return if messages.empty?

    error_content title, message, messages
  end

  private

  def parse_args(args)
    options = args.extract_options!
    first = args.compact.first

    [
      options,
      first&.model_name&.human&.downcase || t('errors.template.unknown_model'),
      first&.errors&.messages&.size || 0
    ]
  end

  def extract_action(options)
    options[:action] || t('activerecord.actions.saved')
  end

  def extract_title(options, model, action, error_count)
    options[:title] || t('errors.template.title_with_action', model: model, action: action, count: error_count)
  end

  def extract_message(options)
    options[:message] || t('errors.template.message')
  end

  def extract_messages(args)
    args.compact.map { |o| o.errors.full_messages }.flatten
  end

  def error_content(title, message, errors)
    content_tag(:article, class: 'message is-danger form-errors') do
      content_tag(:div, class: 'message-header') do
        content_tag(:p, title)
      end +
        content_tag(:div, class: 'message-body') do
          content_tag(:div, class: 'content') do
            content_tag(:p, "#{message}:") +
              content_tag(:ul) do
                errors.each do |msg|
                  concat content_tag(:li, msg)
                end
              end
          end
        end
    end
  end
end
