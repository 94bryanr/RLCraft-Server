FROM openjdk:11
COPY start.sh /
RUN mkdir server \
    && chmod +x start.sh
COPY server.properties /server/
COPY run-server.sh /server/
WORKDIR /server
RUN /start.sh
RUN java -jar installer.jar --installServer \
    && rm -rf installer* \
    && ln -s forge-*.jar server.jar
RUN adduser --system --group forge && \
    chmod +x run-server.sh && \
    mkdir -p /server/server-data && \
    chown -R forge:forge /server
USER forge
EXPOSE 25565
ENTRYPOINT /bin/bash
#ENTRYPOINT /run-server.sh
