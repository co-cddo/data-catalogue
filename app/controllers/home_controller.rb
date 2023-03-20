# frozen_string_literal: true

class HomeController < ApplicationController
  layout 'home'

  def index
    @organisations = Organisation.where.not(name: nil).id_name_order_ASC
  end
end
