require "csv"

puts "Creating content sources..."
CSV.foreach("#{__dir__}/seeds/content_sources.csv", headers: true) do |row|
  source_attrs = row.to_h

  content_source = ContentSource.find_or_initialize_by(guid: source_attrs["guid"])
  content_source.update!(source_attrs)
end
puts "done"
