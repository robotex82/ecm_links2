include ActiveAdmin::ActsAsList::Helper if defined?(ActiveAdmin)
include ActiveAdmin::AwesomeNestedSet::Helper if defined?(ActiveAdmin)

ActiveAdmin.register Ecm::Links::Category do
  # menu entry settings
  menu :parent => Proc.new { I18n.t('ecm.links.active_admin.menu') }.call

  # awesome nested set
  sortable_tree_member_actions

  permit_params :link_footer_column,
                :locale,
                :long_description,
                :markup_language,
                :name,
                :parent_id,
                :short_description,
                ecm_links_links_attributes: [
                  :description,
                  :ecm_links_category_id,
                  :markup_language,
                  :name,
                  :position,
                  :url
                ]


  form do |f|
    f.inputs do
      f.input :parent, :as => :select, :collection => nested_set_options(Ecm::Links::Category, f.object) { |c| "#{'&#160;&#160;&#160;&#160;' * c.level} |-- #{c.to_s}".html_safe }
      f.input :locale, :as => :select, :collection => I18n.available_locales.map(&:to_s)
      f.input :name
      f.input :short_description
      f.input :long_description
    end

    f.inputs do
      f.input :markup_language, :as => :select, :collection => Ecm::Links::Configuration.markup_languages.map(&:to_s)
      f.input :link_footer_column, :as => :select, :collection => (1..Ecm::Links::Configuration.link_footer_columns).to_a
    end

     f.inputs do
      f.has_many :ecm_links_links do |l|
        if l.object.persisted?
          l.input :_destroy, :as => :boolean, :label => I18n.t('active_admin.delete')
        end
        l.input :name
        l.input :url
        l.input :description
      end
    end

    f.actions
  end

  index :as => :nested_set do
    selectable_column
    sortable_tree_columns
    column :locale
    column :name do |c|
      span(:style => "margin-left: #{30 * c.level}px") { c.name }
    end
    column :short_description
    column :ecm_links_links_count
    column :link_footer_column
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :parent
      row :locale
      row :name
      row :ecm_links_links_count
      row :markup_language
      row :link_footer_column
      row :created_at
      row :updated_at
    end

    panel Ecm::Links::Category.human_attribute_name(:short_description) do
      div { ecm_links_category.short_description }
    end

    panel Ecm::Links::Category.human_attribute_name(:long_description) do
      div { ecm_links_category.long_description }
    end

    panel Ecm::Links::Category.human_attribute_name(:children) do
      table_for ecm_links_category.descendants, :i18n => Ecm::Links::Category do
        sortable_tree_columns
        column(:name) { |child| link_to child, [:admin, child], :style => "margin-left: #{30 * (child.level -  ecm_links_category.level - 1)}px" }
        column :short_description
        column :ecm_links_links_count
        column :link_footer_column
        column :created_at
        column :updated_at
        column do |child|
          link_to(I18n.t('active_admin.view'), [:admin, child], :class => "member_link view_link") +
          link_to(I18n.t('active_admin.edit'), [:edit, :admin, child], :class => "member_link edit_link")
        end
      end
    end

    panel Ecm::Links::Category.human_attribute_name(:ecm_links_links) do
      table_for ecm_links_category.ecm_links_links, :i18n => Ecm::Links::Link do
        sortable_columns
        column(:name) { |link| link_to link.name, [:admin, link] }
        column(:url) { |link| link_to link.url, link.url }
        column :created_at
        column :updated_at
        column do |link|
          link_to(I18n.t('active_admin.view'), [:admin, link], :class => "member_link view_link") +
          link_to(I18n.t('active_admin.edit'), [:edit, :admin, link], :class => "member_link edit_link")
        end
      end
    end
  end
end if defined?(ActiveAdmin)
