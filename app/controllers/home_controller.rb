# frozen_string_literal: true

class HomeController < ApplicationController
  layout 'home'

  def index
    @organisations = Organisation.where.not(name: nil).id_name_slug_order_asc
  end
end
