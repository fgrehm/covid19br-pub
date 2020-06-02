require "rails_helper"

RSpec.describe Ingestion::Actions::CheckForRelevancy do
  FIELDS = %i[ title excerpt full_text ]

  [
    "coronavirus", "coronavírus",
    "isolamento social", "distanciamento social",
    "fiqueemcasa", "ficaemcasa",
    "reabertura de serviços não essenciais", "reabertura gradual de serviços não essenciais",
    "reabertura de serviços considerados não essenciais", "reabertura gradual de serviços considerados não essenciais",
    "reabertura de serviços essenciais", "reabertura gradual de serviços essenciais",
    "reabertura de serviços considerados essenciais", "reabertura gradual de serviços considerados essenciais",
    "abertura de serviços não essenciais", "abertura gradual de serviços não essenciais",
    "abertura de serviços considerados não essenciais", "abertura gradual de serviços considerados não essenciais",
    "abertura de serviços essenciais", "abertura gradual de serviços essenciais",
    "abertura de serviços considerados essenciais", "abertura gradual de serviços considerados essenciais",
    "fechamento de serviços não essenciais",
    "fechamento de serviços considerados não essenciais",
    "fechamento de serviços essenciais",
    "fechamento de serviços considerados essenciais",
    "cloroquina", "hidroxicloroquina",
    "hospital de campanha", "hospitais de campanha",
    "quarentena",
    "covid",
    "pandemia",
    "lockdown",
    "respiradores",
  ].each do |relevant_text|
    it "marks as relevant when it has '#{relevant_text}' in it" do
      FIELDS.each do |field|
        ensure_relevant(field, "foo bar #{relevant_text} whatever")
        ensure_relevant(field, "foo bar #{relevant_text} whatever".upcase)
        ensure_relevant(field, "bar#{relevant_text}whatever")
        ensure_relevant(field, "bar#{relevant_text}whatever".upcase)
      end
    end
  end

  [
    "corinavirus", "coronavíruz",
    "izolamento social", "dixtanciamento social",
    "fikeemcasa", "fikaemcasa",
    "quarentenum",
    "covad",
    "pandemiia",
    "fechamento",
    "abertura",
    "reabertura",
    "isolamento",
    "social",
    "distanciamento",
    "essencial",
    "essenciais",
    "emcasa",
    "lockduwn",
  ].each do |text_not_relevant|
    it "marks as not relevant when it has '#{text_not_relevant}' in it" do
      FIELDS.each do |field|
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
