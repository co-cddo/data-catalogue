# frozen_string_literal: true

module OrganisationsHelper
  def organisation_logo(organisation)
    return unless organisation && organisation.name.present?

    if organisation.name == 'Department for Work and Pensions'
      render partial: 'shared/dwp_logo', locals: { organisation: }
    elsif File.exist?("app/assets/images/#{organisation.name}.png")
      image_tag("#{organisation.name}.png", class: 'govuk-image', alt: organisation.name)
    else
      content_tag(:span, organisation.name)
    end
  end
end
