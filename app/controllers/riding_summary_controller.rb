class RidingSummaryController < ApplicationController

  def get_candidate_data(riding_id)
    @riding = Riding.find(riding_id)
    @candidates = Candidate.where(riding_id: riding_id).order(votes: :desc)
    @total_votes = 0
    @candidates.each { |candidate| @total_votes += candidate.votes }
  end

  def view
    get_candidate_data(params[:riding_id])
    @riding_summary = {
        id: params[:riding_id],
        region: @riding.region,
        name: @riding.name,
        candidates: @candidates,
        total_votes: @total_votes
    }
  end

  def data
    get_candidate_data(params[:riding_id])
    respond_to do |format|
      format.json {
        render :json => { candidates: @candidates, total_votes: @total_votes }
      }
    end
  end

end
