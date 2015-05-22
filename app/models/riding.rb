class Riding < ActiveRecord::Base
  has_many :candidates, -> {order 'votes DESC'}

  def self.import(file)
    Riding.destroy_all
    Candidate.destroy_all

    # Read each riding's results, create each Candidate, sum the votes for the riding and create the Riding itself.
    data = CSV.read(file.path, encoding: "ISO8859-1", headers: true, return_headers: false)
    regions = {}
    riding = nil

    data.each do |row|
      unless regions.has_key? row[0]
        regions[row[0]] = []
      end

      unless regions[row[0]].include? row[1]
        regions[row[0]].push row[1]
        riding = Riding.create(name: row[1], region: row[0])
      end

      Candidate.create(name: row[3], party_name: row[4], votes: row[7], riding_id: riding.id)
    end
  end

end
