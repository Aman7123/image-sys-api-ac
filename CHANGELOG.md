# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2021-08-16
### CREATED
- GET: /images?onlyData
  - Is a query param to return no image data, this saves on almost half of minute of response time!
- GET: /images?limit&state
  - Return pagination of image table.

## [1.0.0] - 2021-08-08
### CREATED
- OpenAPI Specification [Swagger Hub Link](https://app.swaggerhub.com/apis/Aaron_Renner/image-sys-api/1.0.0)
- GET: /images (implementation, stored procedures, datasonnet transformation files)
- GET: /images/{uuid} (implementation, stored procedures, datasonnet transformation files)
- POST: /images (implementation, stored procedures)
- PUT: /images/{uuid} (implementation, stored procedures)
- DELETE: /images/{uuid} (implementation, stored procedures)
- CommonElements.java
  - HTTP error builders (Bad Request, Not Found, Server Error)
  - SQL action validation checks
- README.md
  - Created project documentation
- Postman Collection
  - For integration testing (src/test/resources/integration/)

## [SEMVER] - DATE(YYYY-MM-DD)
### ACTION(CREATED, PATCHED, REMOVED)
- DESCRIPTION