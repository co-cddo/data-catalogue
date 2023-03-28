# frozen_string_literal: true

module DataServicesHelper
  def render_data_service_field(value)
    value.present? ? sanitize(format_value(value)) : 'n/a'
  end

  private

  def format_value(value)
    case value
    when Array
      value.map { |v| format_single_value(v) }.join(', ')
    else
      format_single_value(value)
    end
  end

  def format_single_value(value)
    url?(value) ? link_to_url(value) : value
  end

  def link_to_url(url)
    link_to(url, url, class: 'govuk-link')
  end

  def url?(value)
    value =~ URI::DEFAULT_PARSER.make_regexp ? true : false
  end
end
