require "rails_helper"

RSpec.describe Ingestion::Actions::ProcessInput do
  let(:fake_input_model) { instance_double(Input) }

  before do
    allow(Input).to receive(:archive!) { fake_input_model }
  end

  it "works with a hash" do
    raw_input = { title: "How to survive the pandemic" }
    env = { raw_input: raw_input }

    described_class.call(env)

    expect(Input).to have_received(:archive!).with(raw_input)
    expect(env[:raw_input]).to be(raw_input)
    expect(env[:input_model]).to eq(fake_input_model)
  end

  it "works with key to file in S3" do
    input_hash = { "title" => "Lockdown is over!" }
    fake_s3_object = instance_double(Aws::S3::Object)
    expect(fake_s3_object).to receive_message_chain(:get, :body, :string) { input_hash.to_json }
    expect(fake_s3_object).to receive(:delete) { true }

    fake_s3_bucket = instance_double(Aws::S3::Bucket)
    s3_key = "fake-key"
    expect(fake_s3_bucket).to receive(:object).with(s3_key) { fake_s3_object }

    raw_input = { read_from_s3: s3_key }
    env = { raw_input: raw_input, s3_input_bucket: fake_s3_bucket }

    described_class.call(env)

    expect(Input).to have_received(:archive!).with(input_hash)
    expect(env[:raw_input]).to eq(input_hash)
    expect(env[:input_model]).to eq(fake_input_model)
  end

  it "works with an Input model" do
    input_hash = { "title" => "Lockdown is over!" }
    input_model = Input.new
    allow(input_model).to receive(:data) { input_hash }
    env = { raw_input: { input_model: input_model } }

    described_class.call(env)

    expect(Input).to_not have_received(:archive!)
    expect(env[:raw_input]).to eq(input_hash)
    expect(env[:input_model]).to eq(input_model)
  end
end
