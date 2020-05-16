require "rails_helper"

RSpec.describe Content, type: :model do
  describe "#uuid" do
    it "is set upon initialization" do
      expect(described_class.new.uuid).to_not be_nil
      expect(described_class.new(uuid: "foo").uuid).to eq("foo")
    end

    it "is readonly" do
      content = build_content(uuid: "bla")
      content.save!

      uuid = content.uuid
      content.uuid = "other"
      content.save!
      expect(content.reload.uuid).to eq(uuid)
    end
  end

  describe "#full_text" do
    it "can be persisted" do
      content = build_content(full_text: "Some really long text go here")
      content.save!

      from_db = Content.find(content.id)
      expect(from_db.full_text).to eq(content.full_text)
    end

    it "gets hashed" do
      content = build_content(full_text: "Some really long text go here")
      expect(content.full_text_hash).to_not be_nil

      old_hash = content.full_text_hash
      content.full_text = "bla"
      expect(content.full_text_hash).to_not eq(old_hash)
    end
  end

  describe "#excerpt" do
    let(:content) { build_content }

    it "can be persisted" do
      content = build_content(excerpt: "A short summary")
      content.save!

      from_db = Content.find(content.id)
      expect(from_db.excerpt).to eq(content.excerpt)
    end
  end

  describe "#display_text" do
    it "gets truncated if has more than 450 chars" do
      content = build_content(display_text: ("A" * 451))

      expect(content.display_text.size).to eq(450)
    end
  end

  def build_content(attrs = {})
    Content.new({
      uuid: SecureRandom.uuid,
      content_source: build_content_source(attrs.delete(:content_source) || {}),
      content_type: "article",
      found_at: Time.now,
      published_at: 1.hour.ago,
      modified_at: 20.minutes.ago,
      title: "Updates on COVID19 cases",
      display_text: "Something something",
      full_text: "Something something and more something",
      excerpt: "Short summary about something",
      url: "https://gov.com/articles/1",
      url_hash: Digest::SHA1.hexdigest("https://gov.com/articles/1"),
    }.merge(attrs))
  end

  def build_content_source(attrs = {})
    ContentSource.new({
      guid: "br-gov-xpto",
      name: "XPTO State Government",
      region: "Some Region",
      state: "XPTO",
      source_type: "state_government",
      source_scope: "state"
    }.merge(attrs))
  end
end
