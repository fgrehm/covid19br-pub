class ContentsController < ApplicationController
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

  def index
    if params.key?(:state_slug)
      return render(status: 404) unless STATE_SLUGS.key?(params[:state_slug])
    end

    search_params = {
      query: params[:q],
      page: params.fetch(:page, 1),
    }
    search_params[:state_code] = STATE_SLUGS[params[:state_slug]] if params.key?(:state_slug)
    if params.key?(:source_guid)
      @content_source = ContentSource.find_by!(guid: params[:source_guid])
      search_params[:content_source] = @content_source
    end

    @contents = ContentSearch.call(**search_params)

    render :index, layout: false if request.xhr?
  end

  def state_selection
    @states = STATE_SLUGS.keys.map { |slug| { name: slug.titleize, slug: slug } }
  end
end
