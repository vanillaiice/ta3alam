class Setting < ApplicationRecord
  has_one_attached :logo

  def self.instance
    Rails.cache.fetch("setting") do
      first_or_create!(
        organization_name: "My Organization"
      )
    end
  end

  after_commit :clear_cache

  private
  def clear_cache
    Rails.cache.delete("setting")
  end
end
