FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY Hello.java .
RUN javac Hello.java
CMD ["java", "Hello"]
EXPOSE 8082
