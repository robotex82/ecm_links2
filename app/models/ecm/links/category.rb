require_dependency 'redcloth'

class Ecm::Links::Category < ActiveRecord::Base
  # associations
  has_many :ecm_links_links,
           :class_name => Ecm::Links::Link,
           :dependent => :destroy,
           :foreign_key => :ecm_links_category_id # ,
           # :order => 'position'

  # attributes
  attr_accessible :depth,
                  :ecm_links_links_attributes,
                  :lft,
                  :link_footer_column,
                  :locale,
                  :long_description,
                  :markup_language,
                  :name,
                  :parent_id,
                  :rgt,
                  :short_description,
                  :slug if respond_to? :attr_accessible
  accepts_nested_attributes_for :ecm_links_links, :allow_destroy => true

  # awesome nested set
  acts_as_nested_set
  default_scope { order('lft ASC') }

  # callbacks
  after_initialize :set_defaults

  # constants
  MARKUP_LANGUAGES = %w(markdown textile rdoc)

  # friendly id
  extend FriendlyId
  friendly_id :name, :use => [:slugged, :finders]

  # validations
  validates :locale, :presence => true, :if => Proc.new { |c| c.parent.nil? }
  validates :locale, :absence => true, :if => Proc.new { |c| !c.parent.nil? }
  validates :name, :presence => true,
                   :uniqueness => { :scope => [ :parent_id ] }
  validates :markup_language, :presence => true,
                              :inclusion => MARKUP_LANGUAGES

  def to_s
    name
  end

  def self.for_actual_locale
    where(:locale => I18n.locale)
  end

  def self.for_link_footer
    where(self.arel_table['link_footer_column'].not_eq(nil)).for_actual_locale
  end

  def long_description(options = {})
    options.reverse_merge!(:as => :plain)
    case options[:as]
    when :html
      markup(self[:long_description])
    else
      self[:long_description]
    end
  end

  def short_description(options = {})
    options.reverse_merge!(:as => :plain)
    case options[:as]
    when :html
      markup(self[:short_description])
    else
      self[:short_description]
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
      raise "Unsupported markup language #{markup_language}"
    end
  end

  def set_defaults
    if self.new_record?
      self.markup_language ||= 'textile'
    end
  end
end
