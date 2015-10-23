Ecm::Links.configure do |config|
  # Configure your link footer columns here.
  config.link_footer_columns = 4

  # Configure your link footer colum css classes here.
  config.link_footer_column_css_classes = %w[ footer-column span3 ]

  # Set the base controller for the contact form
  #
  # Default: config.base_controller = 'ApplicationController'
  #
  config.base_controller = 'ApplicationController'
end
