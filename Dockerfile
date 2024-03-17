# Official Dart image: https://hub.docker.com/_/dart
# Specify the Dart SDK base image version using dart:<version> (ex: dart:2.14)
FROM dart:stable AS build

WORKDIR /app
COPY packages /app/packages

# Resolve app dependencies.
WORKDIR /app/packages/dart_firebase_functions/example
RUN dart pub get

# Build server codes.
RUN dart pub run build_runner build --delete-conflicting-outputs
RUN dart compile exe bin/server.dart -o bin/server

# Build minimal serving image from AOT-compiled `/server` and required system
# libraries and configuration files stored in `/runtime/` from the build stage.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/packages/dart_firebase_functions/example/bin/server /app/packages/dart_firebase_functions/example/bin/

# Start server.
EXPOSE 8080
# signature-type: http or cloudevent
ENTRYPOINT ["/app/packages/dart_firebase_functions/example/bin/server", "--target=hello", "--signature-type=http"]
