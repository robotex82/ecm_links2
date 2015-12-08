module Ecm
  module Links
    class Routing
      def self.routes(router, options = {})
        options.reverse_merge!(links_category_actions: [:index, :show])

        router.resources :ecm_links_categories, only: options[:links_category_actions], controller: 'ecm/links/categories'
      end
    end
  end
end
