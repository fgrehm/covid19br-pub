module Reporting
  class ContentSourceStatsGenerator
    def self.call(content_source)
      daily_stats = ::ContentSourceDailyStats.find_or_create!(
        # content_source: content_source,
        # date: date,
        # total_tweets: ,
        # relevant_tweets: ,
        # relevant_tweets_removed: ,
        # total_articles: ,
        # relevant_articles_removed:
      )
      # TODO: Query contents_table
    end
  end
end
