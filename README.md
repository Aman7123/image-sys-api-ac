[![BUILDER](https://github.com/Aman7123/image-sys-api-ac/actions/workflows/builder.yml/badge.svg?branch=main)](https://github.com/Aman7123/image-sys-api-ac/actions/workflows/builder.yml)

### image-sys-api-ac
* Version: 1.0.2
* Most up to date implementation will be found in branch `develop`.
* Creator: Aaron Renner
* This API project was generated using MS3's [Camel OpenAPI Archetype](https://github.com/MS3Inc/camel-archetypes), version 0.2.7.

### Introduction
This RESTful API serves image resources. An image resource can be seen in examples below but essentially I am just created a
way to store actual images inside a MySQL database. This RESTful API was designed from the ground up with the help of a Maven
Archetype, specifically one created by @MS3Inc. Using there archetype this project had a total turn around time of 3 Days, this
is including time to create specification, develop implementation and clean up project for release.

### Documentation
* See the Swagger OpenAPI Specification: `https://app.swaggerhub.com/apis-docs/Aaron_Renner/image-sys-api/1.0.0`
* A MySQL schema of Stored Procedures and image database in `src/test/resources/mysql`
* Postman collection and environment variables in `src/test/resources/postman`

### Getting Started
**Running Locally using IDE**
This project uses Spring profiles, and corresponding application properties .yaml files.
All values from the application properties can be overwritten by the environment!
* Use the following environment variables: 
   * ```spring.profiles.active=<env>```
   * ```spring.config.name=<project-name>```

Where the combination of these values determines which properties file to choose from `src/main/resources/` for example in this
folder you will find the provided example file `image-sys-api-ac-dev.yaml`. To access that file a combination of 
`spring.config.name=image-sys-api-ac` and `spring.profiles.active=dev` would be used to run this instance.

Note: IDE specific development
* Eclipse - When modifying this API in Eclipse the VM arguments added to the runtime configuration will be prefixed with `-D`.
  * Example: `-Dspring.profiles.active=dev`

**Running on the Command Line**
The command arguments in a terminal also follow the prefix `-D` rule.
```
mvn spring-boot:run -Dspring-boot.run.arguments="--spring.config.name=image-sys-api-ac --spring.profiles.active=dev"
```

### Docker & Compose & Maven
This project includes a lightweight, portable maven executable that can be used in place of having maven installed.
You will still need Java installed.

When building this application for production I have included the Dockerfile that can allow for building, preparing
and executing all source code in the base directory. Using CI/CD this can all be automated and I will try to include
an example for using Github workflows.

### Actuator Endpoints

To access the list of available Actuator endpoints, go to: `http://<host>:8080/actuator` or `{{url}}/actuator`

The available endpoints are as follows:

* `/health`
* `/metrics`
* `/info`

#### Metrics

List of available metrics can be found here: http://localhost:8080/actuator/metrics/

Add the metric name in `/metrics/<metric name>` to access the metric for that particular topic.

Sample metric: http://localhost:8080/actuator/metrics/jvm.memory.used

```
{
    "name": "jvm.memory.used",
    "description": "The amount of used memory",
    ...
}
```
### Contact

* Aaron Renner (admin@aaronrenner.com)
