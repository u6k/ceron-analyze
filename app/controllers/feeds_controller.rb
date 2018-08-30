class FeedsController < ApplicationController

  def download
    Rails.logger.info "feeds#download: start"

    feed_pages = FeedPage.categories

    Rails.logger.info "feeds#download: download: start"
    feed_pages.each.with_index(1) do |feed_page, index|
      Rails.logger.info "feeds#download: download: #{index}/#{feed_pages.length}"
      feed_page.download_from_web!
    end
    Rails.logger.info "feeds#download: download: end"

    Rails.logger.info "feeds#download: save: start"
    feed_pages.each { |f| f.save! }
    Rails.logger.info "feeds#download: save: end"

    result = {}
    feed_pages.each do |feed_page|
      result[feed_page.type] = { feed_number: feed_page.feeds.length }
    end

    Rails.logger.info "feeds#download: end"
    render json: result
  end

end
