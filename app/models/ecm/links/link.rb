require_dependency 'redcloth'

class Ecm::Links::Link < ActiveRecord::Base
  # acts as list
  acts_as_list scope: :ecm_links_category

  # associations
  belongs_to :ecm_links_category,
             class_name: Ecm::Links::Category,
             counter_cache: :ecm_links_links_count

  # attributes
  attr_accessible :description,
                  :ecm_links_category_id,
                  :markup_language,
                  :name,
                  :position,
                  :url if respond_to? :attr_accessible

  # callbacks
  after_initialize :set_defaults

  # constants
  MARKUP_LANGUAGES = %w(markdown textile rdoc)

  # validations
  validates :name, presence: true # , :uniqueness => { :scope => [ :ecm_links_category_id ] }
  validates :url,  presence: true # , :uniqueness => { :scope => [ :ecm_links_category_id ] }
  validates :markup_language, presence: true,
                              inclusion: MARKUP_LANGUAGES

  def description(options = {})
    options.reverse_merge!(as: :plain)
    case options[:as]
    when :html
      markup(self[:description])
    else
      self[:description]
    end
  end

  private

  def markup(text)
    case markup_language.to_sym
    when :textile
      return unless text
      RedCloth.new(text).to_html
    when :none
      text
    else
      fail "Unsupported markup language #{markup_language}"
    end
  end

  def set_defaults
    self.markup_language ||= 'textile' if self.new_record?
  end
end
