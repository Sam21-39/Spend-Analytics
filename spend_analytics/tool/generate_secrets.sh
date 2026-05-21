#!/usr/bin/env bash
set -euo pipefail

ENV_NAME="${1:-prod}"
case "$ENV_NAME" in
  prod) ;;
  *)
    echo "Invalid env: $ENV_NAME"
    echo "Usage: ./tool/generate_secrets.sh [prod]"
    exit 1
    ;;
esac

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="$ROOT_DIR/assets/env/.env.$ENV_NAME"

if [[ ! -f "$ENV_FILE" ]]; then
  echo "Missing env file: $ENV_FILE"
  exit 1
fi

trim_quotes() {
  local value="$1"
  value="${value%\"}"
  value="${value#\"}"
  value="${value%\'}"
  value="${value#\'}"
  printf '%s' "$value"
}

read_env_value() {
  local key="$1"
  local line
  line="$(grep -E "^${key}=" "$ENV_FILE" | tail -n1 || true)"
  if [[ -z "$line" ]]; then
    printf ''
    return
  fi
  local value="${line#*=}"
  trim_quotes "${value//$'\r'/}"
}

resolve_path() {
  local raw="$1"
  if [[ -z "$raw" ]]; then
    printf ''
    return
  fi
  if [[ "$raw" = /* ]]; then
    printf '%s' "$raw"
  else
    printf '%s/%s' "$ROOT_DIR" "$raw"
  fi
}

ANDROID_SRC_RAW="$(read_env_value "FIREBASE_ANDROID_SERVICE_FILE")"
IOS_SRC_RAW="$(read_env_value "FIREBASE_IOS_SERVICE_FILE")"

ANDROID_SRC="$(resolve_path "${ANDROID_SRC_RAW:-firebase/$ENV_NAME/google-services.json}")"
IOS_SRC="$(resolve_path "${IOS_SRC_RAW:-firebase/$ENV_NAME/GoogleService-Info.plist}")"

ANDROID_DEST="$ROOT_DIR/android/app/google-services.json"
IOS_DEST="$ROOT_DIR/ios/Runner/GoogleService-Info.plist"

if [[ ! -f "$ANDROID_SRC" ]]; then
  echo "Missing Android Firebase config: $ANDROID_SRC"
  echo "Set FIREBASE_ANDROID_SERVICE_FILE in $ENV_FILE or add file at firebase/$ENV_NAME/google-services.json"
  exit 1
fi

mkdir -p "$(dirname "$ANDROID_DEST")"
cp "$ANDROID_SRC" "$ANDROID_DEST"
echo "Updated Android Firebase config -> $ANDROID_DEST"

if [[ -f "$IOS_SRC" ]]; then
  mkdir -p "$(dirname "$IOS_DEST")"
  cp "$IOS_SRC" "$IOS_DEST"
  echo "Updated iOS Firebase config -> $IOS_DEST"
else
  echo "iOS Firebase config not found ($IOS_SRC), skipping iOS copy."
fi

echo "Generating envified secrets for: $ENV_NAME"
fvm dart run envified --env="$ENV_NAME"
echo "Done: lib/core/config/secrets.g.dart"
