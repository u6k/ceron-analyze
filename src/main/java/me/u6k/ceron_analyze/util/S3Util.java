
package me.u6k.ceron_analyze.util;

import com.amazonaws.ClientConfiguration;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder.EndpointConfiguration;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import me.u6k.ceron_analyze.service.CrawlerService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class S3Util {

    private static final Logger L = LoggerFactory.getLogger(CrawlerService.class);

    @Value("${s3.url}")
    private String s3url;

    @Value("${s3.access-id}")
    private String s3accessId;

    @Value("${s3.secret-key}")
    private String s3secretKey;

    @Value("${s3.bucket}")
    private String s3bucket;

    @Value("${s3.timeout}")
    private int s3timeout;

    private AmazonS3 s3;

    public void putObject(String key, String content) {
        this.init();

        L.debug("s3 uploading: key={}, content.length={}", key, content.length());
        this.s3.putObject(this.s3bucket, key, content);
        L.debug("s3 uploaded");
    }

    public int countObject() {
        this.init();

        int count = this.s3.listObjects(this.s3bucket).getObjectSummaries().size();

        return count;
    }

    private synchronized void init() {
        if (this.s3 == null) {
            L.debug("s3.url={}", this.s3url);
            L.debug("s3.access-id={}", this.s3accessId);
            L.debug("s3.secret-key={}", this.s3secretKey);
            L.debug("s3.bucket={}", this.s3bucket);
            L.debug("s3.timeout={}", this.s3timeout);

            AWSCredentials credentials = new BasicAWSCredentials(this.s3accessId, this.s3secretKey);
            ClientConfiguration configuration = new ClientConfiguration();
            configuration.setSocketTimeout(this.s3timeout);
            configuration.setSignerOverride("AWSS3V4SignerType");
            this.s3 = AmazonS3ClientBuilder.standard()
                            .withCredentials(new AWSStaticCredentialsProvider(credentials))
                            .withEndpointConfiguration(new EndpointConfiguration(this.s3url, "us-east-1"))
                            .withClientConfiguration(configuration)
                            .withPathStyleAccessEnabled(true)
                            .build();
        }
    }

}
