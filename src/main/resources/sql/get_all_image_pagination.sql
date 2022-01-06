get_all_image_pagination(
	VARCHAR ${exchangeProperty.limit},
	VARCHAR ${exchangeProperty.page},
	OUT INTEGER current_limit,
	OUT INTEGER current_page,
	OUT INTEGER total_records,
	OUT INTEGER total_pages
)