#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ["sample/sample.csproj", "sample/"]
RUN dotnet restore "sample/sample.csproj"
COPY . .
WORKDIR "/src/sample"
RUN dotnet build "sample.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "sample.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "sample.dll"]

----
FROM registry.redhat.io/openshift4/ose-jenkins-agent-base

COPY helm /usr/bin/helm  ---> untar helm-linux-amd64.tar.gz(Helm 3 CLI) to get helm client. 
RUN chmod +x /usr/bin/helm
