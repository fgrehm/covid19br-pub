class Content < ApplicationRecord
  attr_readonly :uuid

  belongs_to :content_source
  has_one :content_text, dependent: :destroy
  has_many_attached :versions

  delegate :full_text, :full_text=, :excerpt, :excerpt=, :full_text_hash,
           to: :content_text

  after_initialize(unless: :persisted?) do
    self.uuid = SecureRandom.uuid if self.uuid.blank?
  end

  def display_text=(display_text)
    super(display_text.truncate(450))
  end

  def content_text
    super || build_content_text
  end

  # HACK: But does the trick for now
  STATE_SLUGS = {
    "acre" => "AC",
    "alagoas" => "AL",
    "amazonas" => "AM",
    "amapa" => "AP",
    "bahia" => "BA",
    "ceara" => "CE",
    "distrito-federal" => "DF",
    "espirito-santo" => "ES",
    "goias" => "GO",
    "maranhao" => "MA",
    "minas-gerais" => "MG",
    "mato-grosso-do-sul" => "MS",
    "mato-grosso" => "MT",
    "para" => "PA",
    "paraiba" => "PB",
    "pernambuco" => "PE",
    "piaui" => "PI",
    "parana" => "PR",
    "rio-de-janeiro" => "RJ",
    "rio-grande-do-norte" => "RN",
    "rondonia" => "RO",
    "roraima" => "RR",
    "rio-grande-do-sul" => "RS",
    "santa-catarina" => "SC",
    "sergipe" => "SE",
    "sao-paulo" => "SP",
    "tocantins" => "TO",
  }.freeze

  def self.by_state(state_slug)
    where(content_source: ContentSource.find_by(state: STATE_SLUGS[state_slug]))
  end
end
