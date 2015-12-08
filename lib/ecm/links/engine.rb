module Ecm
  module Links
    class Engine < ::Rails::Engine
      initializer :ecm_links_engine do
        ActiveAdmin.setup do |config|
          config.load_paths += Dir[root.join('app', 'admin')]
        end
      end if Gem::Specification.find_all_by_name('activeadmin').any?
    end
  end
end
