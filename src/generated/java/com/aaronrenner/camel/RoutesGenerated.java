package com.aaronrenner.camel;

import javax.annotation.Generated;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import com.ms3_inc.tavros.extensions.rest.OpenApi4jValidator;

/**
 * Generated routes are based on the OpenAPI document in src/generated/api folder.
 *
 * @author Maven Archetype (camel-oas-archetype)
 */
@Generated("com.ms3_inc.camel.archetype.oas")
@Component
public class RoutesGenerated extends BaseRestRouteBuilder {
    private final String contextPath;

    public RoutesGenerated(@Value("${camel.rest.context-path}") String contextPath) {
        super();
        this.contextPath = contextPath;
    }

    /**
     * Defines Apache Camel routes using the OpenAPI REST DSL.
     * Routes are built using a get(PATH) rest message processor.
     *
     * Make changes to this file with caution.
     * If the API specification changes and this file is regenerated,
     * previous changes may be overwritten.
     */
    @Override
    public void configure() throws Exception {
        super.configure();

        restConfiguration().component("undertow");

        interceptFrom()
            .process(new OpenApi4jValidator("image-sys-api.yaml", contextPath));

        rest()
            .get("/images")
                .id("get-images")
                .produces("application/json")
                .to(direct("get-images").getUri())
            .post("/images")
                .id("post-images")
                .consumes("application/json")
                .to(direct("post-images").getUri())
            .get("/images/{uuid}")
                .id("get-images-uuid")
                .produces("application/json")
                .to(direct("get-images-uuid").getUri())
            .put("/images/{uuid}")
                .id("put-images-uuid")
                .consumes("application/json")
                .to(direct("put-images-uuid").getUri())
            .delete("/images/{uuid}")
                .id("delete-images-uuid")
                .to(direct("delete-images-uuid").getUri())
        ;
    }
}
