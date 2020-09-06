FROM openjdk:8-jdk

COPY target/spring-petclinic*.jar /apps/

HEALTHCHECK --interval=1m --timeout=3s --start-period=1m \
  CMD curl -f http://localhost:8080 || exit 1

EXPOSE 8080

CMD java -jar /apps/*jar
