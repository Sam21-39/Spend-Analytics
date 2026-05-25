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

ANDROID_SRC="$ROOT_DIR/firebase/$ENV_NAME/google-services.json"
IOS_SRC="$ROOT_DIR/firebase/$ENV_NAME/GoogleService-Info.plist"

ANDROID_DEST="$ROOT_DIR/android/app/google-services.json"
IOS_DEST="$ROOT_DIR/ios/Runner/GoogleService-Info.plist"

if [[ ! -f "$ANDROID_SRC" ]]; then
  echo "Missing Android Firebase config: $ANDROID_SRC"
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

echo "Done. Dotenv values are read from assets/env/.env at runtime."
