
package me.u6k.ceron_analyze.controller;

import me.u6k.ceron_analyze.service.CrawlerService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CrawlerController {

    private static final Logger L = LoggerFactory.getLogger(CrawlerController.class);

    @Autowired
    private CrawlerService service;

    @RequestMapping(value = "/api/categories/download", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void downloadCategories() {
        L.info("#downloadCategories start");
        try {
            this.service.downloadCategories();
        } finally {
            L.info("#downloadCategories finish");
        }
    }

}
