package com.aaronrenner.camel.implementations;

import static com.aaronrenner.camel.CommonElements.throwBadRequest;
import java.sql.SQLException;
import org.springframework.stereotype.Component;
import com.aaronrenner.camel.BaseRestRouteBuilder;
import com.datasonnet.document.MediaTypes;
import com.ms3_inc.tavros.extensions.rest.exception.BadRequestException;

/**
 * @author Aaron Renner <admin@aaronrenner.com>
 *
 */
@Component
public class GetImagesByUuid extends BaseRestRouteBuilder {

	private String SQLPATH = "classpath:/sql/";
	private String DSPATH = "resource:classpath:/scripts/";
	
	@Override
	public void configure() throws Exception {
		super.configure();
		
		from(direct("get-images-uuid-impl"))
			.routeId("direct:get-images-uuid-impl")
			/** Set properties */
            .setProperty("uuid", simple("${in.headers.uuid}"))
            .doTry()
	            /** Send SQL call */
	            .to(sqlStored(SQLPATH+"get_image_by_uuid.sql"))
	            /** Validate response was returned or throw 404 */
	            .to(direct("validate-sql-get-operation"))
	            /** format response */
	            .transform(datasonnetEx(DSPATH+"getImagesByUuidResponse.ds", String.class)
	            		.bodyMediaType(MediaTypes.APPLICATION_JAVA)
	            		.outputMediaType(MediaTypes.APPLICATION_JSON))
            .doCatch(SQLException.class)
            	.choice()
            		.when(simple("${exception.message} contains 'Data too long for column'"))
            			.throwException(
    						new BadRequestException(
								throwBadRequest(
									"UUID in path must match xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", 
									null
								) // END throwBadRequest
							) // END BadRequestException
						) // END throwException
        		.endChoice()
            .end()
        ;
	}
}
