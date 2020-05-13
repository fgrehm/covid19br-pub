class ContentsController < ApplicationController
  def index
    @contents = Content.order(published_at: :desc).includes(:content_source)
    @contents = @contents.by_state(params[:state_slug]) if params[:state_slug].present?
    @contents = @contents.page(params[:page])

    render :index, layout: false if request.xhr?
  end

  def state_selection
    @states = Content::STATE_SLUGS.keys.map { |slug| { name: slug.titleize, slug: slug } }
  end
end
