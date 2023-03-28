# frozen_string_literal: true

module OrganisationsHelper
  def organisation_logo(organisation)
    return unless organisation && (organisation.name.present? || organisation.slug.present?)

    if organisation.name == 'Department for Work and Pensions'
      render_dwp_logo(organisation)
    else
      render_organisation_logo(organisation)
    end
  end

  private

  def render_dwp_logo(organisation)
    render partial: 'shared/dwp_logo', locals: { organisation: }
  end

  def render_organisation_logo(organisation)
    if organisation_logo_exists?(organisation)
      render_organisation_logo_image(organisation)
    else
      render_organisation_logo_text(organisation)
    end
  end

  def organisation_logo_exists?(organisation)
    File.exist?("app/assets/images/#{organisation.slug}.png")
  end

  def render_organisation_logo_image(organisation)
    image_tag("#{organisation.slug}.png", class: 'govuk-image', alt: organisation.name.presence || organisation.slug)
  end

  def render_organisation_logo_text(organisation)
    content_tag(:span, organisation.name.presence || organisation.slug, class: 'organisation-logo-text')
  end
end
