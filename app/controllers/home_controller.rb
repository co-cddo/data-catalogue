class HomeController < ApplicationController
  def index
    @data_services = DataServices::Fetcher.call(query: params[:query], filters: params[:filters])
    @organisations_checkbox_list = Organisation.select(%i[id name]).order('name ASC')
  end

end
