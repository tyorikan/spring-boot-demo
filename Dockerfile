FROM gradle:8-jdk17 AS java-build
ENV APP_HOME=/app/

WORKDIR $APP_HOME

COPY . .
RUN gradle clean build

FROM gcr.io/distroless/java17-debian11
ENV APP_HOME=/app/

WORKDIR $APP_HOME
COPY --from=java-build $APP_HOME/build/libs/demo.jar .

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "demo.jar"]