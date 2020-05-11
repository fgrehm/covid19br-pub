module Ingestion
  module Actions
    class NormalizeInput
      class << self
        def call(env)
          raw = env.fetch(:raw_input)
          input = raw.except("key").deep_symbolize_keys.merge(__version__: 1)

          # REFACTOR: To use an instance of the action and store an instance variable
          # with the input instead of passing around `input` to all methods
          extract_source(input)
          fix_rss_input(input)
          fix_tweet_input(input)
          normalize_nulls(input, :title, :excerpt, :image_url, :updated_at)
          normalize_whitespace(input, :excerpt)
          if input[:content_type] != "tweet"
            normalize_whitespace(input, :full_text)
          end
          normalize_dates(input, :published_at, :found_at, :updated_at)
          normalize_modified_at(input)
          remove_title_from(input, :full_text, :excerpt)
          rehash_full_text(input)

          env[:input] = input.freeze # just so no other action tries to change it
        end

        private

        def normalize_nulls(input, *keys)
          keys.each do |key|
            input[key] = nil if input[key].blank?
          end
        end

        def extract_source(input)
          input[:__source__] = { tweet_resource: input.delete(:tweet) } if input.key?(:tweet)
          input[:__source__] = { huginn_rss_item: input.delete(:rss_item) } if input.key?(:rss_item)
        end

        def fix_rss_input(input)
          return if input[:updated_at].present?
          return unless input[:__source__]&.key?(:huginn_rss_item)

          rss_item = input[:__source__][:huginn_rss_item]
          return if rss_item[:last_updated].blank?

          input[:updated_at] = rss_item[:last_updated]
        end

        def fix_tweet_input(input)
          return if input[:content_type] != "tweet"

          tweet = input[:__source__][:tweet_resource]
          return unless tweet[:retweeted_status]

          retweet = tweet[:retweeted_status]
          user = retweet[:user][:screen_name]
          input[:full_text] = "RT @#{user}: #{retweet[:full_text]}"
          input[:extra_data] = { retweet: true }
        end

        def remove_title_from(input, *keys)
          title = input[:title]
          return if title.blank?

          keys.each do |key|
            input[key].gsub!(/^#{title}/, "") if input[key]
          end
        end

        def rehash_full_text(input)
          input[:full_text_hash] = Digest::SHA1.hexdigest(input[:full_text])
        end

        def normalize_whitespace(input, *keys)
          keys.each do |key|
            next unless input[key]

            input[key] = input[key].
              gsub(/\r\n/, "\n").
              gsub(/^\s+/, "").
              gsub(/\s+$/, "").
              gsub(/  +/, " ")
          end
        end

        def normalize_dates(input, *keys)
          keys.each do |key|
            input[key] = DateTime.parse(input[key]).utc if input[key]
          end
        end

        def normalize_modified_at(input)
          input[:modified_at] = input.delete(:updated_at)
          input[:modified_at] = nil if input[:modified_at] == input[:published_at]
        end
      end
    end
  end
end
