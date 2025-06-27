# Étape 1 : Build avec Maven
FROM maven:3.9.4-eclipse-temurin-17 AS builder

WORKDIR /app

# Copier les fichiers nécessaires pour build
COPY pom.xml .
COPY src ./src

# Compiler et packager le projet
RUN mvn clean package -DskipTests

# Étape 2 : Image finale avec JAR
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copier le JAR depuis l'étape de build
COPY --from=builder /app/target/*.jar app.jar

# Exposer le port du Spring Boot
EXPOSE 8080

# Lancer l'application
ENTRYPOINT ["java", "-jar", "app.jar"]
