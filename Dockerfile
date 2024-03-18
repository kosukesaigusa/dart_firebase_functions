# Official Dart image: https://hub.docker.com/_/dart
# Specify the Dart SDK base image version using dart:<version> (ex: dart:2.14)
FROM dart:stable AS build

WORKDIR /app
COPY . /app

# Resolve app dependencies.
WORKDIR /app/examples/server
RUN dart pub get

# Build server codes.
RUN dart pub run build_runner build --delete-conflicting-outputs
RUN dart compile exe bin/server.dart -o bin/server

# Build minimal serving image from AOT-compiled `/server` and required system
# libraries and configuration files stored in `/runtime/` from the build stage.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/examples/server/bin/server /app/examples/server/bin/

# Start server.
EXPOSE 8080
# signature-type: http or cloudevent
ENTRYPOINT ["/app/examples/server/bin/server", "--target=hello", "--signature-type=http"]
