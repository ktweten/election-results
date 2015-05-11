class SummaryController < ApplicationController

  def index
    @summary = Summary.new
    if params[:maximum_margin]
      maximum_margin = params[:maximum_margin].to_f
      @summary.set_maximum_margin(maximum_margin)
    end
  end

end
