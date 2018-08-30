require 'test_helper'

class FeedPageTest < ActiveSupport::TestCase

  def setup
    @bucket = NetModule.get_s3_bucket
    @bucket.objects.batch_delete!
  end

  test "download all feed page" do
    # execute - new all feed pages
    feed_pages = FeedPage.categories

    # check
    assert_equal 11, feed_pages.length

    assert_empty_feed_page feed_pages[0], "all", "総合"
    assert_empty_feed_page feed_pages[1], "society", "政治経済"
    assert_empty_feed_page feed_pages[2], "entertainment", "エンタメ"
    assert_empty_feed_page feed_pages[3], "sports", "スポーツ"
    assert_empty_feed_page feed_pages[4], "itnews", "IT"
    assert_empty_feed_page feed_pages[5], "international", "海外"
    assert_empty_feed_page feed_pages[6], "science", "科学"
    assert_empty_feed_page feed_pages[7], "odekake", "おでかけ"
    assert_empty_feed_page feed_pages[8], "2ch", "2ch"
    assert_empty_feed_page feed_pages[9], "neta", "ネタ"
    assert_empty_feed_page feed_pages[10], "movie", "動画"

    # execute - all page download
    feed_pages.each { |f| f.download_from_web! }

    # check
    assert_equal 11, feed_pages.length

    assert_feed_page feed_pages[0], "all", "総合"
    assert_feed_page feed_pages[1], "society", "政治経済"
    assert_feed_page feed_pages[2], "entertainment", "エンタメ"
    assert_feed_page feed_pages[3], "sports", "スポーツ"
    assert_feed_page feed_pages[4], "itnews", "IT"
    assert_feed_page feed_pages[5], "international", "海外"
    assert_feed_page feed_pages[6], "science", "科学"
    assert_feed_page feed_pages[7], "odekake", "おでかけ"
    assert_feed_page feed_pages[8], "2ch", "2ch"
    assert_feed_page feed_pages[9], "neta", "ネタ"
    assert_feed_page feed_pages[10], "movie", "動画"

    # execute - all page save
    feed_pages.each { |f| f.save! }
  end

  test "download from s3" do
    # execute - download when s3 object not found
    feed_page = FeedPage.new("all")
    feed_page.download_from_s3!

    # check
    assert_empty_feed_page feed_page, "all", "総合"

    # execute - download from web and save
    feed_page.download_from_web!
    feed_page.save!

    # check
    assert_feed_page feed_page, "all", "総合"

    # execute - download from s3
    feed_page = FeedPage.new("all")
    feed_page.download_from_s3!

    # check
    assert_feed_page feed_page, "all", "総合"
  end

  test "parse" do
    # execute
    feed_page = FeedPage.new("all", File.open("test/fixtures/files/all.html").read)

    # check
    expected = [
      {
        commentNumber: 270,
        path: "/url/d.hatena.ne.jp/hatenadiary/20180830/blog_unify",
        title: "2019年春「はてなダイアリー」終了のお知らせと「はてなブログ」への移行のお願い - はてなダイアリー日記"
      },
      {
        commentNumber: 139,
        path: "/url/www.fnn.jp/posts/00399793CX",
        title: "体操協会・塚原副会長「彼女がなんであんなうそを」 - FNN.jpプライムオンライン"
      },
      {
        commentNumber: 132,
        path: "/url/nlab.itmedia.co.jp/nl/articles/1808/30/news074.html",
        title: "「はてなダイアリー」2019年春にサービス終了　15年続く一時代を築いたブログサービス - ねとらぼ"
      },
      {
        commentNumber: 110,
        path: "/url/www.fnn.jp/posts/00399794CX",
        title: "【独自】マック赤坂代表　書類送検　元支援者の女性“暴行” - FNN.jpプライムオンライン"
      },
      {
        commentNumber: 104,
        path: "/url/news.denfaminicogamer.jp/kikakuthetower/180830",
        title: "ゲームファンが今遊びたい過去の名作とは？“現行ハードへの移植希望タイトル”アンケート集計結果をエムツーと分析してみた"
      },
      {
        commentNumber: 89,
        path: "/url/www.sponichi.co.jp/soccer/news/2018/08/30/kiji/20180830s00002014150000c.html",
        title: "森保Ｊ初陣メンバー23人発表　若手主体で平均年齢２５・３歳　Ｗ杯から17人入れ替え― スポニチ Sponichi Annex サッカー"
      },
      {
        commentNumber: 70,
        path: "/url/gigazine.net/news/20180830-twitter-suggest-unfollow/",
        title: "Twitterが「このアカウントのフォロー外したら？」機能をテスト - GIGAZINE"
      },
      {
        commentNumber: 192,
        path: "/url/business.nikkeibp.co.jp/atcl/interview/16/082900029/082900001/",
        title: "「オフィスと社員はもう要らない」：日経ビジネスオンライン"
      },
      {
        commentNumber: 154,
        path: "/url/www.sponichi.co.jp/sports/news/2018/08/30/kiji/20180829s00067000418000c.html",
        title: "体操女子・宮川、協会からパワハラ受けた　18歳「勇気」の主張― スポニチ Sponichi Annex スポーツ"
      },
      {
        commentNumber: 162,
        path: "/url/mainichi.jp/articles/20180830/k00/00m/040/181000c",
        title: "経産省：折衝記録「発言要らぬ」　内部文書、指針骨抜き - 毎日新聞"
      },
      {
        commentNumber: 46,
        path: "/url/www.nikkan-gendai.com/articles/view/news/236473",
        title: "“左遷”の森友スクープ記者「記者続けたい」とNHKを退職へ｜日刊ゲンダイDIGITAL"
      },
      {
        commentNumber: 57,
        path: "/url/number.bunshun.jp/articles/-/831749",
        title: "浅尾からサファテへの返信。酷使か、美談か。今こそ“投げ過ぎ”を考える。 - プロ野球 - Number Web - ナンバー"
      },
      {
        commentNumber: 56,
        path: "/url/www3.nhk.or.jp/news/html/20180830/k10011599901000.html",
        title: "福島第一原発 トリチウム水の放出に反対意見多数 公聴会 | NHKニュース"
      },
      {
        commentNumber: 117,
        path: "/url/mainichi.jp/articles/20180830/k00/00m/040/184000c",
        title: "経産省議事録不要：「国民向いていない」身内から批判 - 毎日新聞"
      },
      {
        commentNumber: 100,
        path: "/url/www.dailyshincho.jp/article/2018/08300620/",
        title: "「吐き気がしそう」　百田尚樹氏が「24時間テレビ」を批判する理由 | デイリー新潮"
      },
      {
        commentNumber: 105,
        path: "/url/www.asahi.com/articles/ASL8Y41JKL8YUZHB00C.html",
        title: "畑に急病人「救助に向かいます」　快速列車止めた運転士：朝日新聞デジタル"
      },
      {
        commentNumber: 34,
        path: "/url/www.nikkansports.com/baseball/news/201808300000496.html",
        title: "西武「若獅子寮のカレー風味」ランチパックを発売 - プロ野球 : 日刊スポーツ"
      },
      {
        commentNumber: 104,
        path: "/url/thepage.jp/detail/20180830-00000002-wordleafs",
        title: "体操女子・宮川選手18歳衝撃告発で見えてきた不可解なコーチ暴力処分の陰謀 | THE PAGE（ザ・ページ）"
      },
      {
        commentNumber: 47,
        path: "/url/www.asahi.com/articles/ASL8Y5F9BL8YUTQP012.html",
        title: "アジア大会、ボランティアに日当あり　一般の会社員並み - 一般スポーツ,テニス,バスケット,ラグビー,アメフット,格闘技,陸上：朝日新聞デジタル"
      },
      {
        commentNumber: 47,
        path: "/url/www.oricon.co.jp/news/2118494/full/",
        title: "東出昌大、9・2『ななにー』ゲスト出演　稲垣・草なぎ・香取とピザを賭けて予想バトル | ORICON NEWS"
      },
      {
        commentNumber: 46,
        path: "/url/www.nikkansports.com/soccer/japan/news/201808300000051.html",
        title: "森保ジャパン欧州若手ら招集　秘蔵っ子広島佐々木も - 日本代表 : 日刊スポーツ"
      },
      {
        commentNumber: 45,
        path: "/url/www.news-postseven.com/archives/20180830_750592.html",
        title: "犯行少年が再犯で逮捕、女子高生コンクリ殺人事件の凄惨さ│NEWSポストセブン"
      },
      {
        commentNumber: 41,
        path: "/url/japan.cnet.com/article/35124818/",
        title: "Twitter、フォロー解除すべきアカウントを提案する機能をテスト - CNET Japan"
      },
      {
        commentNumber: 174,
        path: "/url/mainichi.jp/articles/20180829/k00/00m/040/086000c",
        title: "幸福感：収入・学歴より「自己決定度」　神戸大と同大調査 - 毎日新聞"
      },
      {
        commentNumber: 42,
        path: "/url/mainichi.jp/articles/20180830/k00/00m/040/171000c",
        title: "文科省：教員勤務時間、年間で管理　休み期間は上限下げ - 毎日新聞"
      },
      {
        commentNumber: 114,
        path: "/url/www.oricon.co.jp/news/2118473/full/",
        title: "【オリコン】舞祭組、初ライブ映像作品でDVD・BDともに1位獲得 | ORICON NEWS"
      },
      {
        commentNumber: 34,
        path: "/url/this.kiji.is/407741396365050977",
        title: "マック赤坂氏を準強姦容疑などで書類送検 - 共同通信"
      },
      {
        commentNumber: 69,
        path: "/url/www.cinematoday.jp/news/N0103230",
        title: "仮面ライダージオウに「555」の乾巧＆草加雅人が登場決定！ - シネマトゥデイ"
      },
      {
        commentNumber: 63,
        path: "/url/togetter.com/li/1261638",
        title: "日本に３人しかいない銭湯絵師の一人にゴリゴリの美人が弟子入りしてきて銭湯オタク界隈が騒然としてるらしい - Togetter"
      },
      {
        commentNumber: 57,
        path: "/url/mantan-web.jp/article/20180829dog00m200037000c.html",
        title: "仮面ライダージオウ：「555」のファイズ半田健人、カイザ村上幸平が登場 - MANTANWEB（まんたんウェブ）"
      },
      {
        commentNumber: 71,
        path: "/url/news.mynavi.jp/article/20180830-686061/",
        title: "『仮面ライダージオウ』に『555』から乾巧と草加雅人が参戦決定! | マイナビニュース"
      },
      {
        commentNumber: 54,
        path: "/url/pc.watch.impress.co.jp/docs/column/kaimono/1140385.html",
        title: "【買い物山脈】15,980円のカラーレーザーを自宅に設置したらストレスフリーになった同人誌印刷  - PC Watch"
      },
      {
        commentNumber: 78,
        path: "/url/www.bbc.com/japanese/45339136",
        title: "英仏海峡で「ホタテ戦争」　両国の船が衝突、投石も - BBCニュース"
      },
      {
        commentNumber: 22,
        path: "/url/business.nikkeibp.co.jp/atcl/report/15/110879/082900855/",
        title: "スクープ　デサントがワコールと提携：日経ビジネスオンライン"
      },
      {
        commentNumber: 32,
        path: "/url/www.tokyo-np.co.jp/article/national/list/201808/CK2018083002000126.html",
        title: "東京新聞:サマータイム「無理」　夕方予定競技が酷暑に:社会(TOKYO Web)"
      },
      {
        commentNumber: 54,
        path: "/url/toyokeizai.net/articles/-/235607",
        title: "サッポロ､｢ビールもコーヒーも赤字｣の深刻 | 食品 | 東洋経済オンライン | 経済ニュースの新基準"
      },
      {
        commentNumber: 54,
        path: "/url/business.nikkeibp.co.jp/atcl/report/16/081500232/082400011/",
        title: "財投3兆円投入、リニアは第3の森加計問題：日経ビジネスオンライン"
      },
      {
        commentNumber: 27,
        path: "/url/www.asahi.com/articles/ASL8Y72DBL8YUTFK01B.html",
        title: "所在不明の子、全国で２８人　住民票あっても健診受けず：朝日新聞デジタル"
      },
      {
        commentNumber: 25,
        path: "/url/www.fnn-news.com/news/headlines/articles/CONN00399794.html",
        title: "www.fnn-news.com: 【独自】マック赤坂代..."
      },
      {
        commentNumber: 31,
        path: "/url/toyokeizai.net/articles/-/226777",
        title: "｢能力給｣が社員のやる気を削ぎかねないワケ | ワークスタイル | 東洋経済オンライン | 経済ニュースの新基準"
      },
      {
        commentNumber: 26,
        path: "/url/bunshun.jp/articles/-/8772",
        title: "「一生、自分は自分」という人は、そんな自分とどう付き合うのか？ | 文春オンライン"
      },
      {
        commentNumber: 25,
        path: "/url/president.jp/articles/-/26063",
        title: "LINEの逆襲、手数料“0円戦略”の衝撃 (井上 理) | プレジデントオンライン"
      },
      {
        commentNumber: 47,
        path: "/url/togetter.com/li/1261566",
        title: "高校生の時「女の子が理系に進むのはやめた方がいい」と言われプログラマの夢を諦めた女性にプログラマ男性が噛みつく - Togetter"
      },
      {
        commentNumber: 650,
        path: "/url/www3.nhk.or.jp/news/html/20180829/k10011598371000.html",
        title: "ＳＮＳで異なる立場の意見は逆効果 米研究G発表 | NHKニュース"
      },
      {
        commentNumber: 54,
        path: "/url/togetter.com/li/1261340",
        title: "【速報： 角川の代表取締役、個人がDNSを立てられないようにしようと公言】OP53Bは内容規制で情報アクセスそのものを遮断する。フィルタリングのポートが違うだけ、ではない。 - Togetter"
      },
      {
        commentNumber: 43,
        path: "/url/www.bengo4.com/c_1015/c_17/n_8447/",
        title: "「カメ止め」パクリ騒動で相次いだ「検証記事」…福井弁護士が振り返る - 弁護士ドットコム"
      },
      {
        commentNumber: 43,
        path: "/url/this.kiji.is/407616055503602785",
        title: "桜川・砕石場爆発　衝撃、高温に強い爆薬　「1トン爆弾」の威力に匹敵 - 茨城新聞クロスアイ"
      },
      {
        commentNumber: 42,
        path: "/url/natalie.mu/eiga/news/297455",
        title: "「仮面ライダージオウ」555の半田健人＆村上幸平が出演！主題歌は末吉秀太×ISSA（コメントあり） - 映画ナタリー"
      },
      {
        commentNumber: 43,
        path: "/url/mainichi.jp/articles/20180830/ddm/001/010/171000c",
        title: "公文書クライシス：折衝記録「発言要らぬ」　経産省、指針骨抜き　３月省内文書 - 毎日新聞"
      },
      {
        commentNumber: 108,
        path: "/url/www.fnn.jp/posts/00399751CX",
        title: "トランプ氏「真珠湾」発言　安倍首相に“不満” - FNN.jpプライムオンライン"
      },
      {
        commentNumber: 11,
        path: "/url/www3.nhk.or.jp/news/html/20180830/k10011600191000.html",
        title: "マック赤坂代表 支援者の女性に性的暴行の疑いで書類送検 | NHKニュース"
      },
      {
        commentNumber: 14,
        path: "/url/car.watch.impress.co.jp/docs/news/1140652.html",
        title: "ホンダアクセス、「S660」をクラシカルなスタイリングにカスタマイズする「S660 Neo Classic KIT」 - Car Watch"
      },
      {
        commentNumber: 43,
        path: "/url/www.nikkan-gendai.com/articles/view/news/236473",
        title: "“左遷”の森友スクープ記者「記者続けたい」とNHKを退職へ｜日刊ゲンダイDIGITAL"
      },
      {
        commentNumber: 11,
        path: "/url/bunshun.jp/articles/-/8752",
        title: "運が悪い人に特徴的な5つのこと | 文春オンライン"
      },
      {
        commentNumber: 34,
        path: "/url/www.nikkansports.com/baseball/news/201808300000496.html",
        title: "西武「若獅子寮のカレー風味」ランチパックを発売 - プロ野球 : 日刊スポーツ"
      },
      {
        commentNumber: 22,
        path: "/url/business.nikkeibp.co.jp/atcl/report/15/110879/082900855/",
        title: "スクープ　デサントがワコールと提携：日経ビジネスオンライン"
      },
      {
        commentNumber: 138,
        path: "/url/www.fnn.jp/posts/00399793CX",
        title: "体操協会・塚原副会長「彼女がなんであんなうそを」 - FNN.jpプライムオンライン"
      },
      {
        commentNumber: 131,
        path: "/url/nlab.itmedia.co.jp/nl/articles/1808/30/news074.html",
        title: "「はてなダイアリー」2019年春にサービス終了　15年続く一時代を築いたブログサービス - ねとらぼ"
      },
      {
        commentNumber: 110,
        path: "/url/www.fnn.jp/posts/00399794CX",
        title: "【独自】マック赤坂代表　書類送検　元支援者の女性“暴行” - FNN.jpプライムオンライン"
      },
      {
        commentNumber: 103,
        path: "/url/news.denfaminicogamer.jp/kikakuthetower/180830",
        title: "ゲームファンが今遊びたい過去の名作とは？“現行ハードへの移植希望タイトル”アンケート集計結果をエムツーと分析してみた"
      },
      {
        commentNumber: 70,
        path: "/url/gigazine.net/news/20180830-twitter-suggest-unfollow/",
        title: "Twitterが「このアカウントのフォロー外したら？」機能をテスト - GIGAZINE"
      },
      {
        commentNumber: 191,
        path: "/url/business.nikkeibp.co.jp/atcl/interview/16/082900029/082900001/",
        title: "「オフィスと社員はもう要らない」：日経ビジネスオンライン"
      },
      {
        commentNumber: 161,
        path: "/url/mainichi.jp/articles/20180830/k00/00m/040/181000c",
        title: "経産省：折衝記録「発言要らぬ」　内部文書、指針骨抜き - 毎日新聞"
      },
      {
        commentNumber: 57,
        path: "/url/number.bunshun.jp/articles/-/831749",
        title: "浅尾からサファテへの返信。酷使か、美談か。今こそ“投げ過ぎ”を考える。 - プロ野球 - Number Web - ナンバー"
      },
      {
        commentNumber: 43,
        path: "/url/www.nikkan-gendai.com/articles/view/news/236473",
        title: "“左遷”の森友スクープ記者「記者続けたい」とNHKを退職へ｜日刊ゲンダイDIGITAL"
      },
      {
        commentNumber: 56,
        path: "/url/www3.nhk.or.jp/news/html/20180830/k10011599901000.html",
        title: "福島第一原発 トリチウム水の放出に反対意見多数 公聴会 | NHKニュース"
      },
    ]

    assert_equal "all", feed_page.type
    assert_equal "総合", feed_page.title
    assert_equal expected, feed_page.feeds
    assert feed_page.valid?
  end

  def assert_empty_feed_page(feed_page, type, title)
    assert_equal type, feed_page.type
    assert_equal title, feed_page.title
    assert_nil feed_page.feeds
    assert_not feed_page.valid?
  end

  def assert_feed_page(feed_page, type, title)
    assert_equal type, feed_page.type
    assert_equal title, feed_page.title
    assert feed_page.feeds.length > 0
    assert feed_page.valid?

    feed_page.feeds.each do |feed|
      assert_not_nil feed[:url]
      assert_not_nil feed[:title]
      assert_not_nil feed[:commentNumber]
    end
  end

end
