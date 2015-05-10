# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

# Read each riding's results, create each Candidate, sum the votes for the riding and create the Riding itself.
file = File.join(Rails.root, 'app', 'assets', 'csv', 'candidate_results.csv')
data = CSV.read(file, encoding: "ISO8859-1", headers: true, return_headers: false)
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
