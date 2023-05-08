module Bongo
  class Article
    include Mongoid::Document
    include Mongoid::Timestamps::Updated
    include Mongoid::Slug

    slug :title, history: true

    field :title, type: String
    field :text, type: String
    field :publish_at, type: Date

    scope :published, -> { where(:publish_at.lte => Time.zone.today) }

    # Mongoid (v7.0.8) doesn't have a cache_version method on its document.
    # This causes https://jira.mongodb.org/browse/MONGOID-4680 when trying to
    # use Rails collection caching.
    def cache_version
      return unless respond_to?(:updated_at)

      updated_at.utc.to_s(:usec)
    end
  end
end
