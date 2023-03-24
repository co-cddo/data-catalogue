# frozen_string_literal: true

module FilterHelper
  def render_filter_tags(filters, organisations)
    filters = Array.wrap(filters)
    content_tag :ul, class: 'moj-filter-tags' do
      safe_join(render_filter_tag_items(filters, organisations))
    end
  end

  private

  def render_filter_tag_items(filters, organisations)
    filters.map do |filter|
      organisation = organisations.find(filter)
      content_tag :li do
        link_to filter_tag_path(filter, filters), class: 'moj-filter__tag' do
          concat content_tag(:span, 'Remove this filter', class: 'govuk-visually-hidden')
          concat sanitize(organisation.slug)
        end
      end
    end
  end

  def filter_tag_path(filter, filters)
    data_services_path(query: params[:query], filters: filters.reject { |f| f == filter })
  end
end
