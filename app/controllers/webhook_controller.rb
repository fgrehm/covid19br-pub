class WebhookController < ApplicationController
  skip_before_action :verify_authenticity_token

  if Rails.configuration.x.webhook_user.present?
    http_basic_authenticate_with name: Rails.configuration.x.webhook_user,
                                 password: Rails.configuration.x.webhook_password
  end

  def create
    IngestionJob.perform_async(s3_key: params.fetch(:key))
    head :created
  end
end
