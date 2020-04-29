class HomeController < ApplicationController
  def index
    @contents = Content.order(published_at: :desc).includes(:content_source).page(params[:page])
  end
end
