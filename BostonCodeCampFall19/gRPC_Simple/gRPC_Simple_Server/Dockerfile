FROM mcr.microsoft.com/dotnet/core/runtime:3.0-stretch-slim AS base
WORKDIR /app


FROM mcr.microsoft.com/dotnet/core/sdk:3.0-stretch AS build
WORKDIR /src
COPY ["gRPC_Simple_Server/gRPC_Simple_Server.csproj", "gRPC_Simple_Server/"]
COPY ["gRPC_Simple/gRPC_Simple.csproj", "gRPC_Simple/"]
RUN dotnet restore "gRPC_Simple_Server/gRPC_Simple_Server.csproj"
COPY . .
WORKDIR "/src/gRPC_Simple_Server"
RUN dotnet build "gRPC_Simple_Server.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "gRPC_Simple_Server.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "gRPC_Simple_Server.dll"]
EXPOSE 50051