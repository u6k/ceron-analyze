
package me.u6k.ceron_analyze.util;

import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.charset.StandardCharsets;

import org.apache.http.HttpEntity;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public final class NetworkUtil {

    private static final Logger L = LoggerFactory.getLogger(NetworkUtil.class);

    private static final int INTERVAL = 1000;

    private NetworkUtil() {
    }

    public static String get(URL url) {
        L.debug("#get: url={}", url);

        try (CloseableHttpClient client = HttpClients.createDefault()) {
            Thread.sleep(INTERVAL);

            HttpGet get = new HttpGet(url.toURI());
            // get.addHeader("Accept-Encoding", "gzip");

            try (CloseableHttpResponse response = client.execute(get)) {
                L.debug("response: status={}", response.getStatusLine());
                if (response.getStatusLine().getStatusCode() != HttpStatus.SC_OK) {
                    throw new RuntimeException("url=" + url + ", statusCode=" + response.getStatusLine().getStatusCode());
                }
                // if (response.getHeaders("Content-Encoding").length == 0) {
                // throw new RuntimeException("Content-Encoding header not found.");
                // }
                // if (!StringUtils.equals("gzip", response.getFirstHeader("Content-Encoding").getValue())) {
                // throw new RuntimeException("content-encoding=" + response.getFirstHeader("Content-Encoding").getValue() + " is not gzip.");
                // }

                // HttpEntity entity = new GzipDecompressingEntity(response.getEntity());
                HttpEntity entity = response.getEntity();
                byte[] responseData = EntityUtils.toByteArray(entity);
                String html = new String(responseData, StandardCharsets.UTF_8);
                L.debug("response: body={}", html);

                return html;
            }
        } catch (IOException | InterruptedException | URISyntaxException e) {
            throw new RuntimeException(e);
        }
    }

}
