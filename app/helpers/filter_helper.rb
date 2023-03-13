# frozen_string_literal: true

module FilterHelper
  def render_filter_tags(filters, organisations)
    filters = Array.wrap(filters)
    content_tag :ul, class: 'moj-filter-tags' do
      filters.map do |filter|
        organisation = organisations.find(filter)
        content_tag :li do
          link_to data_services_path(query: params[:query], filters: filters.reject { |f| f == filter }), class: 'moj-filter__tag' do
            concat content_tag(:span, organisation.name, class: 'govuk-visually-hidden')
            concat organisation.name
          end
        end
      end.join.html_safe
    end
  end
end
