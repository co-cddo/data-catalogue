# frozen_string_literal: true

class HomeController < ApplicationController
  layout 'home'

  def index
    @organisations = Organisation.select(%i[id name]).order('name ASC')
  end
end
