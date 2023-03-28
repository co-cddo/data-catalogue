# frozen_string_literal: true

class DataResourcesController < ApplicationController
  def index
    @pagy, @data_resources = pagy(DataResources::Fetcher.call(query: params[:query], filters: params[:filters]))
    @organisations = Organisation.joins(:published_resources).distinct.id_name_order_asc
  end
end
