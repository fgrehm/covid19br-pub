module Ingestion
  class Runner
    PIPELINE = [
    ].freeze

    def self.run(input, env: {}, pipeline: PIPELINE)
      env = env.merge(raw_input: input, error: false)
      pipeline.each { |action| !env[:error] && run_action(action, env) }
      env
    end

    def self.run_action(action, env)
      action.call(env)
    rescue RuntimeError => e
      env[:error] = {
        exception: e,
        action: action.name
      }
    end
  end
end
