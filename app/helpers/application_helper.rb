module ApplicationHelper
  def custom_twitter_embed(content_source, url)
    html = OEmbed::Providers.get(url, maxwidth: 550, hide_thread: true, omit_script: true, lang: "pt", dnt: true).html

    doc = Nokogiri::HTML::DocumentFragment.parse(html)
    doc.at_css("blockquote").xpath('child::text()').each { |el| el.remove if el.text.strip.empty? }
    doc.at_css("blockquote").xpath('child::text()').each { |el| el.content = el.text.strip.gsub(/^[^\w]*(\w+)/, "\\1") }

    author = doc.at_css("blockquote").xpath('child::text()').first
    author.wrap('<h3 class="author"></h3>')

    author = doc.at_css(".author")
    text = doc.at_css("blockquote > p")
    author.add_next_sibling(text)

    raw doc.to_html
  rescue OEmbed::NotFound
    "Tweet removido de '#{content_source.name}'"
  end
end
