FROM microsoft/dotnet:sdk AS build-env
WORKDIR /app
EXPOSE 80

# Copy csproj and restore as distinct layers
#COPY DockerDemo/*.csproj ./
#RUN dotnet restore DockerDemo

# Copy everything else and build
COPY . ./
RUN dotnet publish DockerDemo -c Release -o out

# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/DockerDemo/out .
ENTRYPOINT ["dotnet", "dotnet-example.dll"]