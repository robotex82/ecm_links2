require 'rails_helper'

module Ecm
  module Links
    describe CategoriesController do
      describe 'GET index' do
        it 'assigns all ecm_links_categories to @link_categories' do
          link_category = FactoryGirl.create(:ecm_links_category)
          get :index
          assigns(:categories).should eq([link_category])
        end
      end

      describe 'GET show' do
        it 'assigns a ecm_links_category to @link_category' do
          link_category = FactoryGirl.create(:ecm_links_category)
          get :show, id: link_category
          assigns(:category).should eq(link_category)
        end
      end
    end
  end
end
