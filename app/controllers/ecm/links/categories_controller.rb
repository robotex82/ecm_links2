module Ecm::Links
  class CategoriesController < ApplicationController
    def index
      @categories = Category.includes(:ecm_links_links).all.decorate
    end

    def show
      @category = Category.includes(:ecm_links_links).find(params[:id]).decorate
    end
  end
end
