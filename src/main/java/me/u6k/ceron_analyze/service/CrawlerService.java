
package me.u6k.ceron_analyze.service;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import me.u6k.ceron_analyze.util.NetworkUtil;
import me.u6k.ceron_analyze.util.S3Util;
import org.apache.commons.lang3.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CrawlerService {

    private static final Logger L = LoggerFactory.getLogger(CrawlerService.class);

    @Autowired
    private S3Util s3;

    public void downloadAllCategory() {
        L.info("#downloadAllCategory start");
        try {
            /*
             * カテゴリーHTMLをダウンロード
             */
            URL allUrl = new URL("http://ceron.jp/all/");
            String allTitle = "総合";
            String allCategory = "all";
            String downloadTimestamp = new SimpleDateFormat("yyyyMMdd-HHmmss").format(new Date());

            String html = NetworkUtil.get(allUrl);

            /*
             * HTMLを解析、想定している構造かチェック
             */
            Document htmlDoc = Jsoup.parse(html);

            // 見出しをチェック
            Elements elements = htmlDoc.select("h1.page_title");
            if (elements.size() != 1) {
                throw new RuntimeException("h1.page_title.size not 1.");
            }
            Element headE = elements.get(0);
            if (!StringUtils.equals(headE.text(), allTitle)) {
                throw new RuntimeException("head.text=" + headE.val() + " is not \"" + allTitle + "\".");
            }

            // 記事をチェック
            Pattern commentPattern = Pattern.compile("^([0-9]+)コメント$");

            elements = htmlDoc.select("div.item div.item_status span.link_num");
            List<Integer> commentNumbers = elements.stream()
                            .map(x -> {
                                String text = x.text().trim();
                                Matcher m = commentPattern.matcher(text);
                                if (!m.find()) {
                                    throw new RuntimeException("commentText=" + text + " not match.");
                                }
                                String commentCountText = m.group(1);
                                int commentCount = Integer.parseInt(commentCountText);
                                return commentCount;
                            })
                            .collect(Collectors.toList());

            Pattern urlPattern = Pattern.compile("^\\/url\\/(.+)$");

            elements = htmlDoc.select("div.item div.item_title a");
            List<URL> urls = elements.stream()
                            .map(x -> {
                                String text = x.attr("href").trim();
                                Matcher m = urlPattern.matcher(text);
                                if (!m.find()) {
                                    throw new RuntimeException("urlText=" + text + " not match.");
                                }
                                String path = m.group(1);
                                URL url;
                                try {
                                    url = new URL("http://" + path);
                                } catch (MalformedURLException e) {
                                    throw new RuntimeException(e);
                                }
                                return url;
                            })
                            .collect(Collectors.toList());
            List<String> titles = elements.stream()
                            .map(x -> x.text().trim())
                            .collect(Collectors.toList());

            if (commentNumbers.size() != urls.size() || urls.size() != titles.size()) {
                throw new RuntimeException("commentNumbers.size=" + commentNumbers.size()
                                + ", urls.size=" + urls.size()
                                + ", titles.size=" + titles.size() + " not equal.");
            }

            /*
             * HTMLをS3ストレージにアップロード
             */
            String s3key = allCategory + "." + downloadTimestamp + ".html";
            this.s3.putObject(s3key, html);
        } catch (IOException e) {
            throw new RuntimeException("html parse fail.", e);
        } finally {
            L.info("#downloadAllCategory finish");
        }
    }

}
