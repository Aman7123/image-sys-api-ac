package com.aaronrenner.camel.implementations;

import static com.aaronrenner.camel.CommonElements.throwServerError;
import java.sql.SQLException;
import org.springframework.stereotype.Component;
import com.aaronrenner.camel.BaseRestRouteBuilder;
import com.datasonnet.document.MediaTypes;
import com.ms3_inc.tavros.extensions.rest.exception.InternalServerException;

/**
 * @author Aaron Renner <admin@aaronrenner.com>
 *
 */
@Component
public class PostImages extends BaseRestRouteBuilder {

	private String SQLPATH = "classpath:/sql/";
	
	@Override
	public void configure() throws Exception {
		super.configure();
		
		from(direct("post-images-impl"))
			.routeId("direct:post-images-impl")
			/** Pick K/V pairs from JSON incoming body */
            .setProperty("name",        datasonnetEx("payload.name", String.class))
            .setProperty("description", datasonnetEx("payload.description", String.class))
            .setProperty("image",       datasonnetEx("payload.image", String.class))
            .setProperty("imageSize",   datasonnetEx("payload.imageSize", String.class))
            .setProperty("mimeType",    datasonnetEx("payload.mimeType", String.class))
            .setProperty("megapixels",  datasonnetEx("payload.megapixels", String.class))
            .setProperty("metadata",    datasonnetEx("payload.metadata", String.class).outputMediaType(MediaTypes.APPLICATION_JSON))
         
            .doTry()
	            /** Call Stored Procedure */
	            .to(sqlStored(SQLPATH+"create_image.sql"))
	            
	            /** Place outgoing UUID in headers location */
	            .setHeader("location", datasonnetEx("cml.header('CamelHttpUrl') + \"/\" + payload.uuid", String.class).bodyMediaType(MediaTypes.APPLICATION_JAVA))
	            
	            /** Clear response body */
	            .setBody(constant(""))
	            
            .doCatch(SQLException.class)
            	/** If an error occurs in the DB inform the client with 500 */
            	.throwException(
        			new InternalServerException(
    					throwServerError(
							"The image could not be uploaded to the database. Please try again and if the problem persists please contact an admin at admin@aaronrenner.com",
							"It is likely an overload of requests caused UUID generation to fail."
						) // END throwServerError
					) // END InternalServerException
				) // END throwException
            .end()
        ;
	}
}
