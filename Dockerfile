FROM maven:3-openjdk-17

# https://github.com/chrdebru/r2rml
# https://github.com/MaastrichtU-IDS/r2rml/blob/master/Dockerfile

ENV APP_DIR /app
ENV TMP_DIR /tmp/build

WORKDIR $TMP_DIR

RUN git clone https://github.com/chrdebru/r2rml.git .

RUN mvn clean
RUN mvn package
RUN mvn dependency:copy-dependencies

RUN mkdir $APP_DIR && \
    mv target/r2rml.jar $APP_DIR/r2rml.jar && \
    mv target/dependency $APP_DIR/dependency && \
    rm -rf $TMP_DIR

WORKDIR $APP_DIR

ENTRYPOINT ["java","-jar","/app/r2rml.jar"]
