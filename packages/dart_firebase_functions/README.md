# dart_firebase_functions

## Generate codes

```sh
protoc --proto_path=protos --dart_out=grpc:lib/src/internal **/*.proto
dart format lib/src
```
