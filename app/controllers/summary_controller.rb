class SummaryController < ApplicationController


  # def get_ridings
  #   @maximum_margin = 100.0
  #   if params[:max_margin]
  #     @maximum_margin = params[:max_margin].to_f
  #   end
  #
  #   ridings = []
  #   Riding.all.each do |riding|
  #     candidates = Candidate.where(riding_id: riding.id).order(votes: :desc)
  #     votes = []
  #
  #     candidates.each do |candidate|
  #       votes.append candidate.votes
  #     end
  #
  #     riding_margin = get_margin(votes)
  #     if riding_margin <= @maximum_margin
  #       entry = {}
  #       entry['name'] = riding.name
  #       entry['region'] = riding.region
  #       entry['mp_name'] = candidates[0].name
  #       entry['party'] = candidates[0].party_name
  #       entry['margin'] = riding_margin.round(2)
  #       entry['id'] = riding.id
  #       ridings.append(entry)
  #     end
  #   end
  #   return ridings.sort { |a, b| a['margin'] <=> b['margin'] }
  # end

  def index
    @summary = Summary.new
    if params[:maximum_margin]
      maximum_margin = params[:maximum_margin].to_f
      @summary.set_maximum_margin(maximum_margin)
    end
  end

  def data
    respond_to do |format|
      format.json {
        render :json => Summary.get_ridings
      }
    end
  end

end
