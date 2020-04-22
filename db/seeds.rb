puts "Creating content sources..."
[
  {
    guid: "br-gov-am",
    region: "Norte",
    state: "Amazonas",
    name: "Governo Estadual do Amazonas",
    site: "http://www.amazonas.am.gov.br",
    twitter: "AmazonasGoverno"
  },
  {
    guid: "br-gov-ba",
    region: "Nordeste",
    state: "Bahia",
    name: "Governo Estadual da Bahia",
    site: "http://www.ba.gov.br",
    twitter: "governodabahia"
  },
  {
    guid: "br-gov-ce",
    region: "Nordeste",
    state: "Ceará",
    name: "Governo Estadual do Ceará",
    site: "https://www.ceara.gov.br",
    twitter: "governodoceara"
  },
  {
    guid: "br-gov-rj",
    region: "Sudeste",
    state: "Rio de Janeiro",
    name: "Governo Estadual do Rio de Janeiro",
    site: "http://rj.gov.br",
    twitter: "GovRJ"
  },
  {
    guid: "br-gov-rs",
    region: "Sul",
    state: "Rio Grande do Sul",
    name: "Governo Estadual do Rio Grande do Sul",
    site: "https://estado.rs.gov.br",
    twitter: "governo_rs"
  },
  {
    guid: "br-gov-sp",
    region: "Sudeste",
    state: "São Paulo",
    name: "Governo Estadual de São Paulo",
    site: "https://www.saopaulo.sp.gov.br",
    twitter: "governosp"
  },
].each do |source_attrs|
  content_source = ContentSource.find_or_initialize_by(guid: source_attrs[:guid])
  content_source.update!(source_attrs)
end
puts "done"
