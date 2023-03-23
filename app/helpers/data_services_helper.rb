module DataServicesHelper

  def data_service_field(field_value)
    if field_value.present?
      if field_value.is_a?(Array)
        field_value.map do |value|
          if is_url(value)
            link_to(value, value, class: "govuk-link")
          else
            value
          end
        end.join.html_safe
      else
        if is_url(field_value)
          link_to(field_value, field_value, class: "govuk-link")
        else
          field_value
        end
      end
    else
      "n/a"
    end
  end

  private
  def is_url(value)
    value =~ URI::regexp ? true : false
  end

end

