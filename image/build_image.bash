#!/usr/bin/env bash
## Prevent this script from being sourced
#shellcheck disable=SC2317
return 0  2>/dev/null || :

set -eo pipefail

check_set_vars() {
  echo "Checking and setting required variables..."
  [[ -z "$REGISTRY_URL" ]] && {
    echo "Can't build image: \$REGISTRY_URL not defined"
    exit 1
  }

  [[ -z $IMAGE_NAME ]] && {
    echo "Can't build image: \$IMAGE_NAME not defined"
    exit 1
  }

  WORKSPACE_DIR="${WORKSPACE_DIR:-/tmp}"
  OUTFILE="$WORKSPACE_DIR/data.txt"
  SUFFIX=$(date +%Y%m%d%H%M%S)
  IMAGE_URL="$REGISTRY_URL/$IMAGE_NAME:$SUFFIX"
}

build_image() {
  echo "Building image: $IMAGE_URL..."
  {
    docker build . -t "$IMAGE_URL"
    docker push "$IMAGE_URL"
  } && {
    echo "Image built successfully: $IMAGE_URL"
    echo "$IMAGE_URL" >"$OUTFILE"
    echo "Outfile $OUTFILE written"
  }
}

main() {
  check_set_vars
  build_image
}

main "$@"
