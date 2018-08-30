require 'test_helper'

class FeedPageTest < ActiveSupport::TestCase

  def setup
    @bucket = NetModule.get_s3_bucket
    @bucket.objects.batch_delete!
  end

  test "download all feed page" do
    # execute - new index page
    feed_page_all = FeedPage.new

    # check
    assert_empty_feed_page feed_page_all, "all"

    # execute - index page download
    feed_page_all.download_from_web!
    feed_pages = feed_page_all.categories

    # check
    assert_feed_page feed_page_all, "all", "総合"

    assert_equal 11, feed_pages.length

    assert_empty_feed_page feed_pages[0], "all"
    assert_empty_feed_page feed_pages[1], "society"
    assert_empty_feed_page feed_pages[2], "entertainment"
    assert_empty_feed_page feed_pages[3], "sports"
    assert_empty_feed_page feed_pages[4], "itnews"
    assert_empty_feed_page feed_pages[5], "international"
    assert_empty_feed_page feed_pages[6], "science"
    assert_empty_feed_page feed_pages[7], "odekake"
    assert_empty_feed_page feed_pages[8], "movie"
    assert_empty_feed_page feed_pages[9], "2ch"
    assert_empty_feed_page feed_pages[10], "neta"

    # execute - all page download
    feed_pages.each { |f| f.download_from_web! }

    # check
    assert_equal 11, feed_pages.length

    assert_feed_page feed_pages[0], "all", "総合"
    assert_feed_page feed_pages[1], "society", "政治・経済"
    assert_feed_page feed_pages[2], "entertainment", "エンタメ"
    assert_feed_page feed_pages[3], "sports", "スポーツ"
    assert_feed_page feed_pages[4], "itnews", "IT・テクノロジー"
    assert_feed_page feed_pages[5], "international", "海外ニュース"
    assert_feed_page feed_pages[6], "science", "科学・学問"
    assert_feed_page feed_pages[7], "odekake", "おでかけ・イベント"
    assert_feed_page feed_pages[8], "movie", "動画"
    assert_feed_page feed_pages[9], "2ch", "2chまとめ"
    assert_feed_page feed_pages[10], "neta", "ネタ・話題・トピック"

    # execute - all page save
    feed_pages.each { |f| f.save! }
  end

  test "download from s3" do
    # execute - download when s3 object not found
    feed_page = FeedPage.new("all")
    feed_page.download_from_s3!

    # check
    assert_empty_feed_page feed_page, "all"

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








  end

  def assert_empty_feed_page(feed_page, type)
    assert_equal type, feed_page.type
    assert_nil feed_page.title
    assert_nil feed_page.categories
    assert_nil feed_page.feeds
    assert_not feed_page.valid?
  end

  def assert_feed_page(feed_page, type, title)
    assert_equal type, feed_page.type
    assert_equal title, feed_page.title
    assert feed_page.categories.length > 0
    assert feed_page.feeds.length > 0
    assert feed_page.valid?

    feed_page.feeds.each do |feed|
      assert_not_nil feed[:url]
      assert_not_nil feed[:title]
      assert_not_nil feed[:commentNumber]
    end
  end

end
