require "rails_helper"

RSpec.describe Ingestion::Runner do
  let(:fake_exception) { RuntimeError.new("FAIL") }

  it "executes each step of the pipeline" do
    input = { url: "website.com/page" }
    env = { initial: 0 }
    pipeline = [method(:step1), method(:step2)]
    result = described_class.run(input, env: env, pipeline: pipeline)

    expect(result).to eq({
      error: false,
      initial: 0,
      raw_input: input,
      step1: 1,
      step2: 2
    })
  end

  it "halts pipeline execution in case of error" do
    input = { url: "website.com/page" }
    env = { initial: 0 }
    pipeline = [method(:step1), method(:error), method(:step2)]
    result = described_class.run(input, env: env, pipeline: pipeline)

    expect(result).to eq({
      error: false,
      initial: 0,
      raw_input: input,
      step1: 1,
      error: {
        action: :error,
        exception: fake_exception,
      }
    })
  end

  def step1(env)
    env[:step1] = 1
  end

  def step2(env)
    env[:step2] = 2
  end

  def error(env)
    raise fake_exception
  end
end
