class Page
  include Mongoid::Document

  SINGLETON_TYPES = %w{homepage homepage2 news events photos sermons bulletins}
  TYPES = %w{custom collection} + SINGLETON_TYPES

  belongs_to :parent, class_name: "Page", optional: true
  has_many :children, class_name: "Page", inverse_of: :parent, order: :order.asc

  field :title, type: String
  field :content, type: String
  field :identifier, type: String
  field :order, type: Integer, default: 0
  field :type, type: String

  has_many :attachments

  validates :type, inclusion: { in: TYPES }

  before_save do |document|
    document.identifier = document.title.parameterize
  end

  SINGLETON_TYPES.each do |type|
    #TODO validate only one of each type
    define_singleton_method(type) { find_by(type: type) }
  end

  def self.homepage
    Page.find_by(type: { '$in': ['homepage', 'homepage2'] })
  end

  (TYPES - SINGLETON_TYPES).each do |type|
    scope type.pluralize, -> { where(type: type) }
  end

  TYPES.each do |type|
    define_method(type + "?") { self.type == type }
  end

  def homepage?
    type == 'homepage' || homepage2?
  end

  def url_path
    if homepage?
      "/"
    else
      "/#{identifier}"
    end
  end
end
