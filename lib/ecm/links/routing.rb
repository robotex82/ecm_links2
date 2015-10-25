module Ecm
  module Links
    class Routing
      # Creates the routes for categories. You can pass options to
      # specify the actions for categories.
      #
      #   Ecm::Links::Routing.routes(self, { :links_category_actions => [ :index ]})
      #
      # This will only create the index action for link categories.
      def self.routes(router, options = {})
        options.reverse_merge!({
          links_category_actions: [:index, :show]
        })

        router.resources :ecm_links_categories, only: options[:links_category_actions], :controller => 'ecm/links/categories'
      end
#      # Creates the routes for links and categories. You can pass options to
#      # specify the actions for both links and/or categories.
#      #
#      #   Ecm::Links::Routing.routes(self, { :link_category_actions => [ :show ]})
#      #
#      # This will only create the show action for link categories, but omit the index action.
#      def self.routes(router, options = {})
#        options.reverse_merge!(
#          { :link_category_actions => [:index, :show],
#            :link_actions => [:index, :show]
#          }
#        )
#
#        router.resources :ecm_links_categories, :only => options[:link_category_actions], :controller => 'ecm/links/link_categories'
#        router.resources :ecm_links_links,:only => options[:link_actions], :controller => 'ecm/products/links'
#      end
    end
  end
end

