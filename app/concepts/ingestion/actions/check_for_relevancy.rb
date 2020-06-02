module Ingestion
  module Actions
    class CheckForRelevancy
      ATTRS_TO_CHECK = %i[ title excerpt full_text ]
      REGEX = /(coronav(í|i)rus)|covid|pandemia|fi(que|ca)emcasa|lockdown|quarentena|(isolamento|distanciamento) social/i

      def self.call(env)
        input = env.fetch(:input)
        env[:relevant] = ATTRS_TO_CHECK.any? do |attr|
          input[attr] =~ REGEX
        end
      end
    end
  end
end
