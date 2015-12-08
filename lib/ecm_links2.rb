require 'active_admin-acts_as_list' if Gem::Specification.find_all_by_name('activeadmin').any?
require 'active_admin-awesome_nested_set' if Gem::Specification.find_all_by_name('activeadmin').any?
require 'acts_as_list'
require 'awesome_nested_set'
require 'awesome_nested_set-tools'
require 'friendly_id'
require 'draper'

require 'ecm/links/engine'
require 'ecm/links/configuration'
require 'ecm/links/routing'

module Ecm
  module Links
    extend Configuration

    def self.table_name_prefix
      'ecm_links_'
    end
  end
end
