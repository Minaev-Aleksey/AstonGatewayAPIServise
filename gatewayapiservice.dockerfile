# ���������� ����������� ����� OpenJDK
FROM openjdk:17-jdk-slim as builder

# ������������� Maven
RUN apt-get update && apt-get install -y maven git

# ��������� �����������
RUN git clone https://github.com/Minaev-Aleksey/AstonGatewayAPIServise.git /app

# ��������� � ������� ����������
WORKDIR /app

# �������� ������ � ������� Maven
RUN mvn clean package

# ������ ���� - ������� �������� �����
FROM openjdk:17-jdk-slim

# �������� ��������� JAR �� ������� �����
COPY --from=builder /app/target/GatewayAPIService.jar /app/app.jar

# ��������� ����, ������� ���������� ����������
EXPOSE 8080

# ��������� ����������
ENTRYPOINT ["java", "-jar", "/app/app.jar"]