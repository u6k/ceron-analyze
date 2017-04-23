
package me.u6k.ceron_analyze.controller;

import static org.hamcrest.Matchers.*;
import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import me.u6k.ceron_analyze.util.S3Util;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.RequestBuilder;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)
public class CrawlerControllerTest {

    private static final Logger L = LoggerFactory.getLogger(CrawlerControllerTest.class);

    @Autowired
    private WebApplicationContext context;

    private MockMvc mvc;

    @Autowired
    private S3Util s3;

    @Before
    public void setup() {
        this.mvc = MockMvcBuilders.webAppContextSetup(context).build();

        this.s3.deleteAllObject();
    }

    private ResultActions perform(MockMvc mvc, RequestBuilder request) throws Exception {
        ResultActions result = mvc.perform(request);

        MockHttpServletResponse response = result.andReturn().getResponse();
        L.debug("response: status={}, body={}", response.getStatus(), response.getContentAsString());

        return result;
    }

    @Test
    public void downloadCategories() throws Exception {
        ResultActions result = perform(mvc, post("/api/categories/download"));

        result.andExpect(status().isNoContent());

        assertThat(this.s3.countObject(), is(11));
    }

}
