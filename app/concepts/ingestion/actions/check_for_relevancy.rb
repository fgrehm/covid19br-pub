module Ingestion
  module Actions
    # TODO: Need to check for dates too!!!!
    class CheckForRelevancy
      ATTRS_TO_CHECK = %i[ title excerpt full_text ]
      KEYWORDS = [
        "(coronav(í|i)rus)",
        "covid",
        "pandemia",
        "fi(que|ca)emcasa",
        "lockdown",
        "quarentena",
        "(isolamento|distanciamento) social",
        "respiradores",
        "cloroquina",
        "hospita(l|is) de campanha",
        "(fechamento|(re|)abertura)( gradual|) de serviços( considerados|)( não|) essenciais",
      ]
      REGEX = /#{KEYWORDS.join("|")}/i

      def self.call(env)
        input = env.fetch(:input)
        env[:relevant] = ATTRS_TO_CHECK.any? do |attr|
          input[attr] =~ REGEX
        end
      end
    end
  end
end
