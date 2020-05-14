class ContentSourcesController < ApplicationController
  def index
    @content_sources = ContentSource.order(:state)
  end
end
