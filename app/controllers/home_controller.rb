# frozen_string_literal: true

class HomeController < ApplicationController
  layout 'home'

  def index
    @organisations = Organisation.joins(:published_resources).distinct.id_name_order_asc
  end
end
