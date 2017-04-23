
package me.u6k.ceron_analyze.service;

import static org.hamcrest.CoreMatchers.*;
import static org.junit.Assert.*;

import me.u6k.ceron_analyze.util.S3Util;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class CrawlerServiceTest {

    @Autowired
    private CrawlerService service;

    @Autowired
    private S3Util s3;

    @Test
    public void downloadAllCategory() throws Exception {
        this.service.downloadAllCategory();

        int count = this.s3.countObject();
        assertThat(count, is(11));

        Thread.sleep(10000);

        this.service.downloadAllCategory();

        count = this.s3.countObject();
        assertThat(count, is(22));
    }

}
