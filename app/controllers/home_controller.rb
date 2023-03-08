# frozen_string_literal: true

class HomeController < ApplicationController
  layout 'home'

  def index
    @organisations = Organisation.id_name_order_ASC
  end
end
