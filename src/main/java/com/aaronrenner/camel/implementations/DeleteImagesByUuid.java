package com.aaronrenner.camel.implementations;

import static com.aaronrenner.camel.CommonElements.throwBadRequest;
import java.sql.SQLException;
import org.springframework.stereotype.Component;
import com.aaronrenner.camel.BaseRestRouteBuilder;
import com.ms3_inc.tavros.extensions.rest.exception.BadRequestException;

/**
 * @author Aaron Renner <admin@aaronrenner.com>
 *
 */
@Component
public class DeleteImagesByUuid extends BaseRestRouteBuilder {

	private String SQLPATH = "classpath:/sql/";
	
	@Override
	public void configure() throws Exception {
		super.configure();
		
		from(direct("delete-images-uuid-impl"))
			.routeId("direct:delete-images-uuid-impl")
            /** Set properties */
            .setProperty("uuid", simple("${in.headers.uuid}"))
            .doTry()
	            /** Send SQL call */
	            .to(sqlStored(SQLPATH+"delete_image_by_uuid.sql"))
	            /** Validate action performed or throw 404 */
	            .to(direct("validate-sql-update-operation"))
	            /** clear body for response */
	            .setBody(constant(""))
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
