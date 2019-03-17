require "nokogiri"
require "crawline"

require "ceron_analyze/version"

module CeronAnalyze
  class FeedParser < Crawline::BaseParser
    def initialize(url, data)
      @logger = AppLogger.get_logger
      @logger.debug("FeedParser#initialize: start: url=#{url}, data.size=#{data.size}")

      _parse(url, data)
    end

    def redownload?
      true
    end

    def valid?
      ((not @related_links.empty?) &&
        (not @feeds.empty?))
    end

    def related_links
      @related_links
    end

    def parse(context)
      context[@category] = @feeds if not @category.nil?
    end

    private

    def _parse(url, data)
      @logger.debug("FeedParser#_parse: start")

      @category = url.match(/^https:\/\/ceron\.jp\/(\w+)\/$/) do |category|
        @logger.debug("FeedParser#_parse: menu_bar_inner: category=#{category}")
        @category = category[1]
      end

      doc = Nokogiri::HTML.parse(data, nil, "UTF-8")

      @related_links = doc.xpath("//div[@id='menu_bar_inner']/ul/li/a").map do |a|
        @logger.debug("FeedParser#_parse: menu_bar_inner: a=#{a.inspect}")

        URI.join(url, a["href"]).to_s
      end

      @feeds = doc.xpath("//div[@class='item_list_box']/div[contains(@class, 'item')]").map do |div|
        @logger.debug("FeedParser#_parse: item: div=#{div.inspect}")

        {
          "comment_number" => div.at_xpath("div[@class='item_status']/span[contains(@class, 'link_num')]").text.to_i,
          "url" => div.at_xpath("div[@class='item_status']/a[@class='item_direct']")["href"],
        }
      end
    end
  end

  class AppLogger
    @@logger = nil

    def self.get_logger
      if @@logger.nil?
        @@logger = Logger.new(STDOUT)
        @@logger.level = ENV["SHR_LOGGER_LEVEL"] if ENV.has_key?("SHR_LOGGER_LEVEL")
      end

      @@logger
    end
  end
end
