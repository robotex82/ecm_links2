require 'rails_helper'

describe "routing to categories" do
  it "routes /ecm_links_categories to index" do
    expect(:get => "/ecm_links_categories").to route_to(
      :controller => "ecm/links/categories",
      :action => "index"
    )
  end # it
end

