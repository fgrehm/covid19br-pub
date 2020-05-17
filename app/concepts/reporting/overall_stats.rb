module Reporting
  class OverallStats
    QUERY = <<~SQL
      SELECT
        sc.published_at::date,
        -- sc.content_type,
        COUNT(1) AS analyzed,
        SUM(CASE sc.content_id IS NOT NULL WHEN TRUE THEN 1 ELSE 0 END) AS relevant
        -- ,
        -- SUM(CASE sc.detected_removal_at IS NOT NULL WHEN TRUE THEN 1 ELSE 0 END) AS deleted
      FROM scraped_contents AS sc
        JOIN content_sources AS cs ON sc.content_source_id = cs.id
      GROUP BY sc.published_at::date --, sc.content_type
      ORDER BY sc.published_at::date ASC;
    SQL
    def self.call
      rows = ApplicationRecord.connection.select_all(QUERY)
      {
        dates: rows.map { |r| r.fetch("published_at") },
        analyzed: rows.map { |r| r.fetch("analyzed") },
        relevant: rows.map { |r| r.fetch("relevant") },
        total_analyzed: rows.sum { |r| r.fetch("analyzed") },
        total_relevant: rows.sum { |r| r.fetch("relevant") },
      }
    end
  end
end
