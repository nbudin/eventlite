class CmsFile < ApplicationRecord
  belongs_to :parent, polymorphic: true
  belongs_to :uploader, class_name: 'User'
  mount_uploader :file, CmsFileUploader

  validates_integrity_of :file
  validates_processing_of :file
  validate :validate_file_name_is_unique

  def to_param
    "#{id}-#{filename.to_param}"
  end

  def filename
    File.basename(file.path)
  end

  def is_image?
    file.content_type =~ /\Aimage\//
  end

  private

  def validate_file_name_is_unique
    if CmsFile.where(file: file.filename).any?
      errors.add :file, "'#{file.filename}' already exists"
    end
  end
end
