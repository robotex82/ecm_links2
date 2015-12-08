include ActiveAdmin::ActsAsList::Helper if defined?(ActiveAdmin)

ActiveAdmin.register Ecm::Links::Link do
  # menu entry settings
  menu parent: proc { I18n.t('ecm.links.active_admin.menu') }.call

  permit_params :description,
                :ecm_links_category_id,
                :markup_language,
                :name,
                :position,
                :url

  # acts as list
  sortable_member_actions

  form do |f|
    f.inputs do
      f.input :ecm_links_category, as: :select, collection: nested_set_options(Ecm::Links::Category) { |c| "#{'&#160;&#160;&#160;&#160;' * c.level} |-- #{c}".html_safe }
      f.input :name
      f.input :url
      f.input :description
    end

    f.inputs do
      f.input :markup_language, as: :select, collection: Ecm::Links::Link::MARKUP_LANGUAGES
    end

    f.actions
  end

  index do
    selectable_column
    column :ecm_links_category
    column :name
    column :url
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :ecm_links_category
      row :name
      row :url
      row :markup_language
      row :created_at
      row :updated_at
    end

    panel Ecm::Links::Link.human_attribute_name(:description) do
      div { ecm_links_link.description }
    end
  end
end if defined?(ActiveAdmin)
