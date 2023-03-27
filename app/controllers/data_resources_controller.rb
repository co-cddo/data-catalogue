# frozen_string_literal: true

class DataResourcesController < ApplicationController
  def index
    @pagy, @data_resources = pagy(DataResources::Fetcher.call(query: params[:query], filters: params[:filters]))
    @organisations = Organisation.where.not(name: nil).id_name_slug_order_asc
  end
end
