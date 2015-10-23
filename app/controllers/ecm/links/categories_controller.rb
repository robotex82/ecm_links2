class Ecm::Links::CategoriesController < ApplicationController
  def index
    @link_categories = ::Ecm::Links::Category.includes(:ecm_links_links)
  end
  
  def show
    @link_category = ::Ecm::Links::Category.includes(:ecm_links_links).find(params[:id])
  end
end
