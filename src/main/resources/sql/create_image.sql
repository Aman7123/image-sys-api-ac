create_image(
	VARCHAR ${exchangeProperty.image},
	VARCHAR ${exchangeProperty.name},
	VARCHAR ${exchangeProperty.description},
	VARCHAR ${exchangeProperty.imageSize},
	VARCHAR ${exchangeProperty.mimeType},
	DOUBLE ${exchangeProperty.megapixels},
	VARCHAR ${exchangeProperty.metadata},
	OUT VARCHAR uuid
)