class StatsController < ApplicationController
  def index
    @report = Reporting::OverallStats.call
  end
end
