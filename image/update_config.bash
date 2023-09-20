#!/usr/bin/env bash
## Prevent this script from being sourced
#shellcheck disable=SC2317
return 0  2>/dev/null || :

set -eo pipefail

check_set_vars() {
  echo "Checking and setting required variables..."
  [[ -z $WORKSTATIONS_CONFIG_NAME ]] && {
      echo "Can't update Workstations config: \$WORKSTATIONS_CONFIG_NAME not defined"
      exit 1
  }

  WORKSPACE_DIR="${WORKSPACE_DIR:-/tmp}"
  IMAGE_URL=$(cat "$WORKSPACE_DIR/data.txt")
}

update_workstation() {
  echo "Updating Cloud Workstations config with image URL $IMAGE_URL"

  gcloud beta workstations configs update "$WS_CONFIG_NAME" \
      --project "$PROJECT_ID" \
      --region "$REGION" \
      --container-custom-image "$IMAGE_URL" \
      --quiet && echo "Cloud Workstations config updated"
  curl -X PATCH \
      "https://workstations.googleapis.com/v1beta/$WORKSTATIONS_CONFIG_NAME?updateMask=container.image" \
      -H "Authorization: Bearer $(gcloud auth print-access-token)" \
      -H "Content-Type: application/json" \
      -d "{\"container\": {\"image\": \"$IMAGE_URL\"}}" && echo "Cloud Workstations config updated"
}

main() {
    check_set_vars
    update_workstation
}

main "$@"