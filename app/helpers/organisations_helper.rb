# frozen_string_literal: true

module OrganisationsHelper
  def organisation_logo(organisation)
    if organisation.name == 'Department for Work and Pensions'
      render partial: 'shared/dwp_logo', locals: { organisation: }, class: 'govuk-image',
             alt: 'Department for Work and Pensions'
    elsif File.exist?("app/assets/images/#{organisation.name.parameterize(separator: '')}.png")
      image_tag("#{organisation.name.parameterize(separator: '')}.png", class: 'govuk-image', alt: organisation.name)
    else
      content_tag(:span, organisation.name)
    end
  end
end
