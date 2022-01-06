package com.aaronrenner.camel.implementations;

import org.springframework.stereotype.Component;
import com.aaronrenner.camel.BaseRestRouteBuilder;
import com.datasonnet.document.MediaTypes;

/**
 * @author Aaron Renner <admin@aaronrenner.com>
 * @version 2.0
 *
 */
@Component
public class GetImages extends BaseRestRouteBuilder {

	private String SQLPATH = "classpath:/sql/";
	private String DSPATH = "resource:classpath:/scripts/";
	
	@Override
	public void configure() throws Exception {
		super.configure();
		
		from(direct("get-images-impl"))
			.routeId("direct:get-images-impl")
			/** Attempt to grab limit and page query params, or set null */
			.setProperty("limit", 	 simple("${in.headers.limit}"))
			.setProperty("page", 	 simple("${in.headers.page}"))
			.setProperty("onlyData", simple("${in.headers.onlyData}", Boolean.class))

			.choice()
				.when(simple("${exchangeProperty.onlyData} == true"))
					/** Call Stored Procedure - onlyData, NO IMAGE COLUMN */
			        .to(sqlStored(SQLPATH+"get_all_image_without_image.sql"))
			        
			        /** Format the response body and force JSON */
			        .transform(datasonnetEx(DSPATH+"getImagesOnlyDataResponse.ds", String.class)
			        		.bodyMediaType(MediaTypes.APPLICATION_JAVA)
			        		.outputMediaType(MediaTypes.APPLICATION_JSON))
				.when(simple("${exchangeProperty.limit} != null && ${exchangeProperty.page} != null"))
			        /** Call Stored Procedure - Pagination */
			        .to(sqlStored(SQLPATH+"get_all_image_pagination.sql"))
			        
			        /** Format the response body and force JSON */
			        .transform(datasonnetEx(DSPATH+"getImagesPaginationResponse.ds", String.class)
			        		.bodyMediaType(MediaTypes.APPLICATION_JAVA)
			        		.outputMediaType(MediaTypes.APPLICATION_JSON))
				.otherwise()
			        /** Call Stored Procedure */
			        .to(sqlStored(SQLPATH+"get_all_image.sql"))
			        
			        /** Format the response body and force JSON */
			        .transform(datasonnetEx(DSPATH+"getImagesResponse.ds", String.class)
			        		.bodyMediaType(MediaTypes.APPLICATION_JAVA)
			        		.outputMediaType(MediaTypes.APPLICATION_JSON))
	        .end()
		;
	}
}
