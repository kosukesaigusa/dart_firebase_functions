include secrets.mk

.PHONY: clean

SERVER_DIR = packages/dart_firebase_functions/example
FUNCTION_TARGET = oncreatetodo
REGION = asia-northeast1
FUNCTION_SIGNATURE_TYPE = cloudevent
MAX_INSTANCE_LIMIT = 1
MEMORY_LIMIT = 256Mi

server_build:
	cd $(SERVER_DIR) && dart run build_runner build --delete-conflicting-outputs

build: server_build

test: clean build
	cd $(SERVER_DIR) && dart test

clean:
	cd $(SERVER_DIR) && dart run build_runner clean

run: build
	cd $(SERVER_DIR) && dart run bin/server.dart --target=$(FUNCTION_TARGET) --signature-type=$(FUNCTION_SIGNATURE_TYPE)

# https://cloud.google.com/sdk/gcloud/reference/run/deploy
# https://cloud.google.com/functions/docs/configuring/max-instances
# https://cloud.google.com/functions/docs/configuring/memory
deploy-function: build
	gcloud run deploy $(FUNCTION_TARGET) \
		--source=. \
		--region=$(REGION) \
		--project=$(PROJECT_ID) \
		--no-allow-unauthenticated \
		--max-instances $(MAX_INSTANCE_LIMIT) \
		--memory=$(MEMORY_LIMIT) \
		--set-env-vars=ENVIRONMENT=production \
		--set-secrets=PROJECT_ID=PROJECT_ID:latest,CLIENT_ID=CLIENT_ID:latest,CLIENT_EMAIL=CLIENT_EMAIL:latest,PRIVATE_KEY=PRIVATE_KEY:latest,LINE_CHANNEL_ID=LINE_CHANNEL_ID:latest \
		--quiet

deploy-unauthenticated-function: build
	gcloud run deploy $(FUNCTION_TARGET) \
		--source=. \
		--region=$(REGION) \
		--project=$(PROJECT_ID) \
		--allow-unauthenticated \
		--max-instances $(MAX_INSTANCE_LIMIT) \
		--memory=$(MEMORY_LIMIT) \
		--set-env-vars=ENVIRONMENT=production \
		--set-secrets=PROJECT_ID=PROJECT_ID:latest,CLIENT_ID=CLIENT_ID:latest,CLIENT_EMAIL=CLIENT_EMAIL:latest,PRIVATE_KEY=PRIVATE_KEY:latest,LINE_CHANNEL_ID=LINE_CHANNEL_ID:latest \
		--quiet

# https://cloud.google.com/sdk/gcloud/reference/run/services/list
list-services:
	gcloud run services list \
		--platform managed \
		--region=$(REGION) \
		--project=$(PROJECT_ID)

# https://cloud.google.com/sdk/gcloud/reference/run/services/delete
delete-service:
	gcloud run services delete $(FUNCTION_TARGET) \
		--platform managed \
		--region=$(REGION) \
		--project=$(PROJECT_ID) \
		--quiet

# https://cloud.google.com/sdk/gcloud/reference/eventarc/triggers/create
# https://cloud.google.com/eventarc/docs/run/route-trigger-eventarc
# https://cloud.google.com/eventarc/docs/run/route-trigger-cloud-firestore
deploy-trigger:
	gcloud eventarc triggers create $(FUNCTION_TARGET) \
    --location=$(REGION) \
    --destination-run-service=$(FUNCTION_TARGET) \
    --event-filters="type=google.cloud.firestore.document.v1.created" \
    --event-filters="database=(default)" \
    --event-filters="namespace=(default)" \
    --event-filters-path-pattern="document=todos/{todoId}" \
    --event-data-content-type="application/protobuf" \
    --service-account="$(EVENT_ARC_SERVICE_ACCOUNT_NAME)@$(PROJECT_ID).iam.gserviceaccount.com" \
		--project=$(PROJECT_ID)

# https://cloud.google.com/sdk/gcloud/reference/eventarc/triggers/describe
check-trigger:
	gcloud eventarc triggers describe $(FUNCTION_TARGET) \
		--location=$(REGION) \
		--project=$(PROJECT_ID)

# https://cloud.google.com/sdk/gcloud/reference/eventarc/triggers/delete
delete-trigger:
	gcloud eventarc triggers delete $(FUNCTION_TARGET) \
		--location=$(REGION) \
		--project=$(PROJECT_ID)
		--quiet

delete: delete-trigger delete-service
