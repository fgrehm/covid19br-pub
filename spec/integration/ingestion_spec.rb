require "rails_helper"

RSpec.describe "Ingestion processing" do
  it "creates a tweet Content based on input" do
    expect {
      ingest!("tweet-relevant")
    }.to change(Content.tweets, :count).by(1)
  end

  it "ignores irrelevant tweets" do
    expect {
      ingest!("tweet-not_relevant")
    }.to_not change(Content.tweets, :count)
  end

  it "creates an article Content based on input" do
    expect {
      ingest!("article-relevant")
    }.to change(Content.articles, :count).by(1)
  end

  it "ignores irrelevant articles" do
    expect {
      ingest!("article-not_relevant")
    }.to_not change(Content.articles, :count)
  end

  it "is idempotent" do
    expect {
      5.times { ingest!("article-relevant") }
    }.to change(Content.articles, :count).by(1)
  end

  it "indexes content for searching" do
    expect(ContentSearch.call(query: "paulista").total_count).to eq(0)

    ingest!("article-relevant")

    expect(ContentSearch.call(query: "paulista").total_count).to eq(1)
    expect(ContentSearch.call(query: "LotsOfNonSense").total_count).to eq(0)
  end

  it "upserts a ScrapedContent regardless of relevancy" do
    expect {
      ingest!("article-relevant")
      ingest!("tweet-not_relevant")
    }.to change(ScrapedContent, :count).by(2)

    expect {
      ingest!("article-relevant")
      ingest!("tweet-not_relevant")
    }.to_not change(ScrapedContent, :count)
  end

  def ingest!(input_name)
    ingest(read_input(input_name)).tap do |result|
      raise result[:error][:exception] if result[:error]
    end
  end

  def read_input(name)
    input = JSON.parse(Rails.root.join("spec/fixtures/ingestion/#{name}.json").read)
    prepare_content_source(input)
    input
  end

  def prepare_content_source(input)
    content_source = ::ContentSource.find_or_initialize_by(
      guid: input.fetch("source_guid")
    )
    content_source.update!(
      region: "Norte",
      state: "BA",
      name: "Governo Estadual #{content_source.guid}",
      source_scope: "state",
      source_type: "state_government"
    )
  end

  def ingest(input)
    Ingestion::Runner.run(input)
  end
end
