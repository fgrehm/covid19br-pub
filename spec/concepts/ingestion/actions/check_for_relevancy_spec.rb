require "rails_helper"

RSpec.describe Ingestion::Actions::CheckForRelevancy do
  FIELDS = %i[ title excerpt full_text ]

  [
    "coronavirus", "coronavírus",
    "isolamento social", "distanciamento social",
    "quarentena",
    "covid",
    "pandemia",
    "fiqueemcasa", "ficaemcasa",
    "lockdown",
  ].each do |relevant_text|
    FIELDS.each do |field|
      it "marks '#{field}' as relevant when it has '#{relevant_text}' in it" do
        ensure_relevant(field, "foo bar #{relevant_text} whatever")
        ensure_relevant(field, "bar#{relevant_text}whatever")
      end
    end
  end

  [
    "corinavirus", "coronavíruz",
    "izolamento social", "dixtanciamento social",
    "quarentenum",
    "covad",
    "pandemiia",
    "fikeemcasa", "fikaemcasa",
    "lockduwn",
  ].each do |text_not_relevant|
    FIELDS.each do |field|
      it "marks '#{field}' as not relevant when it has '#{text_not_relevant}' in it" do
        ensure_not_relevant(field, "foo bar #{text_not_relevant} whatever")
        ensure_not_relevant(field, "bar#{text_not_relevant}whatever")
      end
    end
  end

  def ensure_relevant(field, text)
    env = { input: { field => text } }
    described_class.call(env)

    expect(env.fetch(:relevant)).to be true
  end

  def ensure_not_relevant(field, text)
    env = { input: { field => text } }
    described_class.call(env)

    expect(env.fetch(:relevant)).not_to be true
  end
end
