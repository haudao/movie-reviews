require 'open-uri'

class DataService
  BASE_GALAXYCINE_URL = 'https://www.galaxycine.vn/phim-dang-chieu'.freeze

  def crawl_data
    hrefs = []

    page = Nokogiri::HTML(open(BASE_GALAXYCINE_URL))
    doc = page.css("div[class='caption']").css('a')
    doc.each { |link| hrefs.push(link['href']) }
    hrefs.each { |href| push_data_to_database(href) }
  end

  private

  def push_data_to_database(href)
    page = Nokogiri::HTML(open(href))
    doc = page.css("section[class='general-block film-info detail']")
    Movie.create(
      title: doc.css('h3')[0].text,
      poster: doc.css('img')[0]['src'],
      plot: doc.css("section[class='ck-editor hidden']").css('p')[0].text,
      rating: 0
    )
  end
end
