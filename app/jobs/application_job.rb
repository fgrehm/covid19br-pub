class ApplicationJob
  include Sidekiq::Worker
  sidekiq_options retry: 10, backtrace: Rails.env.development?
end
