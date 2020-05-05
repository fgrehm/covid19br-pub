class ContentsController < ApplicationController
  def index
    @contents = Content.order(published_at: :desc).includes(:content_source)
    @contents = @contents.by_state(params[:state_slug]) if params[:state_slug].present?
    @contents = @contents.page(params[:page])
  end
end
