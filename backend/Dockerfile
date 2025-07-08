FROM --platform=$BUILDPLATFORM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# 第二阶段：运行应用程序
FROM openjdk:17
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
RUN chmod +x app.jar
EXPOSE 8080
CMD ["java", "-jar", "./app.jar"]