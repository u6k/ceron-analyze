require "webmock/rspec"

RSpec.describe CeronAnalyze do
  it "has a version number" do
    expect(CeronAnalyze::VERSION).not_to be nil
  end
end

RSpec.describe CeronAnalyze::FeedParser do
  before do
    url = "https://ceron.jp/all/"
    data = File.open("spec/data/all.html").read

    @parser = CeronAnalyze::FeedParser.new(url, data)
  end

  describe "#redownload?" do
    it "is always redownload" do
      expect(@parser).to be_redownload
    end
  end

  describe "#valid?" do
    it "is always valid" do
      expect(@parser).to be_valid
    end
  end

  describe "#related_links" do
    it "is category pages" do
      expect(@parser.related_links).to contain_exactly(
        "https://ceron.jp/",
        "https://ceron.jp/all/newitem/",
        "https://ceron.jp/all/",
        "https://ceron.jp/society/",
        "https://ceron.jp/entertainment/",
        "https://ceron.jp/sports/",
        "https://ceron.jp/itnews/",
        "https://ceron.jp/international/",
        "https://ceron.jp/science/",
        "https://ceron.jp/2ch/",
        "https://ceron.jp/neta/",
        "https://ceron.jp/movie/",
        "https://ceron.jp/comic/",
        "https://ceron.jp/ranking/day/")
    end
  end

  describe "#parse" do
    it "is feeds" do
      context = {}

      @parser.parse(context)

      expect(context["all"]).to contain_exactly(
        {
          "comment_number" => 106,
          "url" => "http://www.mbs.jp/news/sp/zenkokunews/20190315/3623043.shtml",
        },
        {
          "comment_number" => 96,
          "url" => "http://www.tokyo-sports.co.jp/entame/entertainment/1309606/",
        },
        {
          "comment_number" => 184,
          "url" => "http://www.itmedia.co.jp/news/articles/1903/15/news081.html",
        },
        {
          "comment_number" => 144,
          "url" => "http://www.nikkansports.com/entertainment/news/201903150000286.html",
        },
        {
          "comment_number" => 69,
          "url" => "http://www3.nhk.or.jp/news/html/20190315/k10011849641000.html",
        },
        {
          "comment_number" => 58,
          "url" => "http://this.kiji.is/479175422691869793",
        },
        {
          "comment_number" => 61,
          "url" => "http://getnews.jp/archives/2133315",
        },
        {
          "comment_number" => 214,
          "url" => "http://www.itmedia.co.jp/business/articles/1903/15/news030.html",
        },
        {
          "comment_number" => 79,
          "url" => "http://www.jiji.com/jc/article?k=2019031500746&g=int",
        },
        {
          "comment_number" => 60,
          "url" => "http://mainichi.jp/articles/20190315/k00/00m/030/120000c",
        },
        {
          "comment_number" => 47,
          "url" => "http://www.daily.co.jp/baseball/2019/03/15/0012148570.shtml",
        },
        {
          "comment_number" => 120,
          "url" => "http://www.asahi.com/articles/ASM3H2QYHM3HUTQP002.html",
        },
        {
          "comment_number" => 381,
          "url" => "http://www.sponichi.co.jp/entertainment/news/2019/03/15/kiji/20190314s00041000419000c.html",
        },
        {
          "comment_number" => 88,
          "url" => "http://www.asahi.com/articles/ASM3D5JXLM3DUTIL02Y.html",
        },
        {
          "comment_number" => 104,
          "url" => "http://gendai.ismedia.jp/articles/-/63519",
        },
        {
          "comment_number" => 97,
          "url" => "http://www.huffingtonpost.jp/entry/ryuichi-sakamoto_jp_5c8b0282e4b03e83bdbee6a5",
        },
        {
          "comment_number" => 99,
          "url" => "http://jp.techcrunch.com/2019/03/15/line-pay-google-pay-apple-pay/",
        },
        {
          "comment_number" => 38,
          "url" => "http://www.asahi.com/articles/ASM3H351HM3HULFA002.html",
        },
        {
          "comment_number" => 66,
          "url" => "http://www.nikkei.com/article/DGXMZO42495830V10C19A3000000/",
        },
        {
          "comment_number" => 44,
          "url" => "http://natalie.mu/music/news/324043",
        },
        {
          "comment_number" => 65,
          "url" => "http://blogos.com/article/364206/",
        },
        {
          "comment_number" => 41,
          "url" => "http://www3.nhk.or.jp/news/html/20190315/k10011849131000.html",
        },
        {
          "comment_number" => 88,
          "url" => "http://www.jiji.com/jc/article?k=2019031400978&g=pol",
        },
        {
          "comment_number" => 29,
          "url" => "http://www3.nhk.or.jp/news/html/20190315/k10011849571000.html",
        },
        {
          "comment_number" => 68,
          "url" => "http://www.nikkei.com/article/DGXMZO42496720V10C19A3I00000/",
        },
        {
          "comment_number" => 90,
          "url" => "http://www.nikkei.com/article/DGXMZO42438740U9A310C1EAF000/",
        },
        {
          "comment_number" => 50,
          "url" => "http://www.inside-games.jp/article/2019/03/15/121103.html",
        },
        {
          "comment_number" => 22,
          "url" => "http://gigazine.net/news/20190315-epic-game-launcher-send-steam-data/",
        },
        {
          "comment_number" => 133,
          "url" => "http://mainichi.jp/articles/20190314/k00/00m/020/287000c",
        },
        {
          "comment_number" => 59,
          "url" => "http://togetter.com/li/1328278",
        },
        {
          "comment_number" => 41,
          "url" => "http://www.sponichi.co.jp/entertainment/news/2019/03/15/kiji/20190315s00041000200000c.html",
        },
        {
          "comment_number" => 56,
          "url" => "http://kabumatome.doorblog.jp/archives/65937781.html",
        },
        {
          "comment_number" => 32,
          "url" => "http://gigazine.net/news/20190315-apple-icloud-system-down/",
        },
        {
          "comment_number" => 45,
          "url" => "http://www.nikkansports.com/entertainment/news/201903140001210.html",
        },
        {
          "comment_number" => 78,
          "url" => "http://www.sponichi.co.jp/baseball/news/2019/03/14/kiji/20190315s00001007038000c.html",
        },
        {
          "comment_number" => 321,
          "url" => "http://www.asahi.com/articles/ASM3G4TR0M3GUTIL026.html",
        },
        {
          "comment_number" => 62,
          "url" => "http://bunshun.jp/articles/-/10987",
        },
        {
          "comment_number" => 167,
          "url" => "http://www3.nhk.or.jp/news/html/20190315/k10011848901000.html",
        },
        {
          "comment_number" => 324,
          "url" => "http://www.asahi.com/articles/ASM3G53PKM3GUTFK01C.html",
        },
        {
          "comment_number" => 81,
          "url" => "http://www.nikkei.com/article/DGXMZO42491490V10C19A3000000/",
        },
        {
          "comment_number" => 30,
          "url" => "http://news.careerconnection.jp/?p=68731",
        },
        {
          "comment_number" => 51,
          "url" => "http://this.kiji.is/479035626653582433",
        },
        {
          "comment_number" => 50,
          "url" => "http://www.nikkei.com/article/DGXLRSP505094_U9A310C1000000/",
        },
        {
          "comment_number" => 138,
          "url" => "http://www3.nhk.or.jp/news/html/20190314/k10011848031000.html",
        },
        {
          "comment_number" => 55,
          "url" => "http://mainichi.jp/sportsspecial/articles/20190314/k00/00m/040/274000c",
        },
        {
          "comment_number" => 73,
          "url" => "http://toyokeizai.net/articles/-/270718",
        },
        {
          "comment_number" => 75,
          "url" => "http://nlab.itmedia.co.jp/nl/articles/1903/14/news112.html",
        },
        {
          "comment_number" => 282,
          "url" => "http://www.itmedia.co.jp/news/articles/1903/14/news148.html",
        },
        {
          "comment_number" => 23,
          "url" => "http://j-town.net/tokyo/research/results/277142.html",
        },
        {
          "comment_number" => 43,
          "url" => "http://natalie.mu/music/news/324043",
        },
        {
          "comment_number" => 27,
          "url" => "http://lineblog.me/kitamura_yukiya/archives/1564397.html",
        },
        {
          "comment_number" => 291,
          "url" => "http://www3.nhk.or.jp/news/html/20190315/k10011849741000.html",
        },
        {
          "comment_number" => 14,
          "url" => "http://www.cnn.co.jp/world/35134279.html",
        },
        {
          "comment_number" => 10,
          "url" => "http://www.zakzak.co.jp/soc/news/190315/soc1903150008-n1.html",
        },
        {
          "comment_number" => 14,
          "url" => "http://www3.nhk.or.jp/news/html/20190315/k10011849611000.html",
        },
        {
          "comment_number" => 105,
          "url" => "http://www.mbs.jp/news/sp/zenkokunews/20190315/3623043.shtml",
        },
        {
          "comment_number" => 95,
          "url" => "http://www.tokyo-sports.co.jp/entame/entertainment/1309606/",
        },
        {
          "comment_number" => 291,
          "url" => "http://www3.nhk.or.jp/news/html/20190315/k10011849741000.html",
        },
        {
          "comment_number" => 61,
          "url" => "http://getnews.jp/archives/2133315",
        },
        {
          "comment_number" => 213,
          "url" => "http://www.itmedia.co.jp/business/articles/1903/15/news030.html",
        },
        {
          "comment_number" => 47,
          "url" => "http://www.daily.co.jp/baseball/2019/03/15/0012148570.shtml",
        },
        {
          "comment_number" => 14,
          "url" => "http://www3.nhk.or.jp/news/html/20190315/k10011849611000.html",
        },
        {
          "comment_number" => 22,
          "url" => "http://gigazine.net/news/20190315-epic-game-launcher-send-steam-data/",
        },
        {
          "comment_number" => 57,
          "url" => "http://this.kiji.is/479175422691869793",
        },
        {
          "comment_number" => 38,
          "url" => "http://www.asahi.com/articles/ASM3H351HM3HULFA002.html",
        },
        {
          "comment_number" => 59,
          "url" => "http://togetter.com/li/1328278",
        },
        {
          "comment_number" => 17,
          "url" => "http://hamusoku.com/archives/10010088.html",
        },
        {
          "comment_number" => 102,
          "url" => "http://gendai.ismedia.jp/articles/-/63519",
        },
        {
          "comment_number" => 78,
          "url" => "http://www.jiji.com/jc/article?k=2019031500746&g=int",
        },
        {
          "comment_number" => 66,
          "url" => "http://www3.nhk.or.jp/news/html/20190315/k10011849641000.html",
        },
        {
          "comment_number" => 182,
          "url" => "http://www.itmedia.co.jp/news/articles/1903/15/news081.html",
        })
    end
  end
end

RSpec.describe Crawline::Engine do
  before do
    # Setup webmock
    WebMock.enable!

    WebMock.stub_request(:get, "https://ceron.jp/2ch/").to_return(
      body: File.open("spec/data/2ch.html").read,
      status: [200, "OK"])

    WebMock.stub_request(:get, "https://ceron.jp/all/").to_return(
      body: File.open("spec/data/all.html").read,
      status: [200, "OK"])

    WebMock.stub_request(:get, "https://ceron.jp/all/newitem/").to_return(
      body: File.open("spec/data/all_newitem.html").read,
      status: [200, "OK"])

    WebMock.stub_request(:get, "https://ceron.jp/comic/").to_return(
      body: File.open("spec/data/comic.html").read,
      status: [200, "OK"])

    WebMock.stub_request(:get, "https://ceron.jp/entertainment/").to_return(
      body: File.open("spec/data/entertainment.html").read,
      status: [200, "OK"])

    WebMock.stub_request(:get, "https://ceron.jp/").to_return(
      body: File.open("spec/data/index.html").read,
      status: [200, "OK"])

    WebMock.stub_request(:get, "https://ceron.jp/international/").to_return(
      body: File.open("spec/data/international.html").read,
      status: [200, "OK"])

    WebMock.stub_request(:get, "https://ceron.jp/itnews/").to_return(
      body: File.open("spec/data/itnews.html").read,
      status: [200, "OK"])

    WebMock.stub_request(:get, "https://ceron.jp/movie/").to_return(
      body: File.open("spec/data/movie.html").read,
      status: [200, "OK"])

    WebMock.stub_request(:get, "https://ceron.jp/neta/").to_return(
      body: File.open("spec/data/neta.html").read,
      status: [200, "OK"])

    WebMock.stub_request(:get, "https://ceron.jp/ranking/day/").to_return(
      body: File.open("spec/data/ranking_day.html").read,
      status: [200, "OK"])

    WebMock.stub_request(:get, "https://ceron.jp/science/").to_return(
      body: File.open("spec/data/science.html").read,
      status: [200, "OK"])

    WebMock.stub_request(:get, "https://ceron.jp/society/").to_return(
      body: File.open("spec/data/society.html").read,
      status: [200, "OK"])

    WebMock.stub_request(:get, "https://ceron.jp/sports/").to_return(
      body: File.open("spec/data/sports.html").read,
      status: [200, "OK"])

    WebMock.disable_net_connect!(allow: "s3")

    # Setup engine
    downloader = Crawline::Downloader.new("ceron-analyze/#{CeronAnalyze::VERSION} (https://github.com/u6k/ceron-analyze)")

    repo = Crawline::ResourceRepository.new(
      ENV["AWS_S3_ACCESS_KEY"],
      ENV["AWS_S3_SECRET_KEY"],
      ENV["AWS_S3_REGION"],
      ENV["AWS_S3_BUCKET"],
      ENV["AWS_S3_ENDPOINT"],
      ENV["AWS_S3_FORCE_PATH_STYLE"])

    parsers = {
      /https:\/\/ceron\.jp\/.*/ => CeronAnalyze::FeedParser
    }

    @engine = Crawline::Engine.new(downloader, repo, parsers, 0.001)
  end

  after do
    WebMock.disable!
  end

  it "is context data when crawl" do
    @engine.crawl("https://ceron.jp/")
    context = @engine.parse("https://ceron.jp/")

    pp context

    expect(context["2ch"].size).to be > 0
    expect(context["all"].size).to be > 0
    expect(context["comic"].size).to be > 0
    expect(context["entertainment"].size).to be > 0
    expect(context["international"].size).to be > 0
    expect(context["itnews"].size).to be > 0
    expect(context["movie"].size).to be > 0
    expect(context["neta"].size).to be > 0
    expect(context["science"].size).to be > 0
    expect(context["society"].size).to be > 0
    expect(context["sports"].size).to be > 0
  end
end

