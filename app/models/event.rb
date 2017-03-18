class Event < ApplicationRecord
  belongs_to :root_page, class_name: "Page"
  has_many :pages, as: :parent

  validates :name, presence: true

  before_save :generate_slug
  after_save :create_default_root_page

  def start_time=(start_time)
    start_time = DateTime.iso8601(start_time) if start_time.is_a?(String)
    write_attribute(:start_time, start_time)

    if @end_time
      self.length_seconds = @end_time.to_i - start_time.to_i
    end

    start_time
  end

  def end_time
    return unless start_time && length_seconds
    start_time + length_seconds
  end

  def end_time=(end_time)
    end_time = DateTime.iso8601(end_time) if end_time.is_a?(String)
    @end_time = end_time

    if start_time
      self.length_seconds = (end_time.to_i - start_time.to_i)
    elsif length_seconds
      self.start_time = (end_time - length_seconds)
    end

    end_time
  end

  def to_param
    slug
  end

  private

  def generate_slug
    return if slug.present?
    return unless name

    self.slug = Cadmus::Slugs.slugify(name)
  end

  def create_default_root_page
    return if root_page

    create_root_page!(name: "Home", content: "Content goes here", parent: self)
    save!
  end
end
