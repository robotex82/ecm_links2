require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/hash_with_indifferent_access'

module Ecm
  module Links
    module Configuration
      def configure
        yield self
      end

      mattr_accessor :link_footer_columns do
        4
      end

      mattr_accessor :link_footer_column_css_classes do
        'link-footer-column col-lg-3'
      end

      mattr_accessor :base_controller do
        'ApplicationController'
      end

      mattr_accessor :default_markup_language do
        'textile'
      end

      mattr_accessor :markup_languages do
        ['textile']
      end
    end
  end
end
