require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  # Protect against timing attacks:
  # - See https://codahale.com/a-lesson-in-timing-attacks/
  # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
  # - Use & (do not use &&) so that it doesn't short circuit.
  # - Use digests to stop length information leaking (see also ActiveSupport::SecurityUtils.variable_size_secure_compare)
  ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(Rails.configuration.x.sidekiq_user)) &
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(Rails.configuration.x.sidekiq_password))
end if Rails.configuration.x.sidekiq_user.present?

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  post "/webhook", to: "webhook#create"
  get "/:state_slug", to: "contents#index"
  root to: "contents#index"
end
