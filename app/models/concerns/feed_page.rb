class FeedPage
  extend ActiveSupport::Concern

  attr_reader :type, :title, :feeds

  def self.categories
    [
      FeedPage.new("all"),
      FeedPage.new("society"),
      FeedPage.new("entertainment"),
      FeedPage.new("sports"),
      FeedPage.new("itnews"),
      FeedPage.new("international"),
      FeedPage.new("science"),
      FeedPage.new("2ch"),
      FeedPage.new("neta"),
      FeedPage.new("movie")
    ]
  end

  def initialize(type, content = nil)
    @type = type
    @content = content

    _parse
  end

  def download_from_web!
    @content = NetModule.download_with_get(_build_url)

    _parse
  end

  def download_from_s3!
    @content = NetModule.get_s3_object(NetModule.get_s3_bucket, _build_s3_path)

    _parse
  end

  def valid?
    ((not @type.nil?) \
      && (not @title.nil?) \
      && (not @feeds.nil?))
  end

  def save!
    if not valid?
      raise "Invalid"
    end

    NetModule.put_s3_object(NetModule.get_s3_bucket, _build_s3_path, @content)
  end

  private

  def _parse
    if @content.nil?
      return nil
    end

    doc = Nokogiri::HTML.parse(@content, nil, "UTF-8")

    doc.xpath("//h1[@class='page_title']").each do |h1|
      @title = h1.text.strip
    end

    @feeds = doc.xpath("//div[@class='item_status']/span[contains(@class, 'link_num')]").map do |span|
      { comment_number: span.text.strip.to_i }
    end

    doc.xpath("//div[@class='item_title']/a").each.with_index do |a, index|
      @feeds[index][:path] = a[:href]
      @feeds[index][:title] = a.text.strip
    end
  end

  def _build_url
    "http://ceron.jp/#{@type}/"
  end

  def _build_s3_path
    Settings.s3.folder + "/#{@type}/#{@type}.html"
  end

end
