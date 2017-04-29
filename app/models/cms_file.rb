class CmsFile < ApplicationRecord
  belongs_to :uploader, class_name: 'User'
  mount_uploader :file, CmsFileUploader

  cadmus_file :file
end
