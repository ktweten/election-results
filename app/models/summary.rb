class Summary

  def initialize
    @maximum_margin = 100.0
  end

  def get_maximum_margin
    return @maximum_margin
  end

  def set_maximum_margin(margin)
    @maximum_margin = margin
  end

  def sum_votes(votes)
    sum = 0
    votes.each { |vote| sum += vote }
    return sum
  end

  def get_margin(votes)
    total = sum_votes votes
    margin = votes.length < 2 ? 100.0 : (votes[0] - votes[1])* 100.0/total
  end

  def get_ridings(margin = @maximum_margin)
    ridings = []
    Riding.all.each do |riding|
      candidates = Candidate.where(riding_id: riding.id).order(votes: :desc)
      votes = []

      candidates.each do |candidate|
        votes.append candidate.votes
      end

      riding_margin = get_margin(votes)
      if riding_margin <= @maximum_margin
        entry = {}
        entry['name'] = riding.name
        entry['region'] = riding.region
        entry['mp_name'] = candidates[0].name
        entry['party'] = candidates[0].party_name
        entry['margin'] = riding_margin.round(2)
        entry['id'] = riding.id
        ridings.append(entry)
      end
    end
    return ridings.sort { |a, b| b['margin'] <=> a['margin'] }
  end

end
