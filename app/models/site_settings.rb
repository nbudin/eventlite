class SiteSettings < ApplicationRecord
  def self.instance
    first
  end
end
