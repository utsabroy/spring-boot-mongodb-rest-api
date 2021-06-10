# Build Stage

#################### USING MAVEN BUILD ################
FROM maven:3.6.3-adoptopenjdk-11 as build-env

VOLUME /tmp
WORKDIR /

COPY ./pom.xml .

RUN mvn dependency:go-offline -B

COPY ./src ./src

RUN mvn package
RUN ls
RUN mv ./target/*.jar /*.jar

#################### Package Stage ################
FROM amazoncorretto:11-al2-full

RUN yum install -y \
    shadow-utils && \
    yum clean all

ENV APPUSER=appuser
ENV APPUID=1000
ENV APPGID=1000

RUN useradd \
    --home "/app" \
    --create-home \
    --user-group \
    --uid "$APPUID" \
    "$APPUSER"

WORKDIR /app
USER appuser

COPY --chown=appuser:appuser --from=build-env /*.jar .

EXPOSE 8080

CMD exec java $JAVA_OPTS -jar /app/*.jar
