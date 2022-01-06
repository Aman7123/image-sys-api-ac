package com.aaronrenner.camel;

import org.springframework.stereotype.Component;

/**
 * The RoutesImplementation class holds implementations for the end points configured in RoutesGenerated.
 * These routes are based on operation Ids, that correspond to an API end point:  method+path.
 *
 * @author Maven Archetype (camel-openapi-archetype)
 * @author Aaron Renner <admin@aaronrenner.com>
 */
@Component
public class RoutesImplementation extends BaseRestRouteBuilder {
	

    @Override
    public void configure() throws Exception {
        super.configure();

        from(direct("get-images"))
            .to(direct("get-images-impl"))
        ;
        
        from(direct("post-images"))
            .to(direct("post-images-impl"))
        ;
        
        from(direct("get-images-uuid"))
            .to(direct("get-images-uuid-impl"))
        ;
        
        from(direct("put-images-uuid"))
            .to(direct("put-images-uuid-impl"))
        ;
        
        from(direct("delete-images-uuid"))
            .to(direct("delete-images-uuid-impl"))
        ;

    }
}
