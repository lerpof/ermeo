#!/usr/bin/env bash
# Fetch canonical OpenAPI from a running Beneesse API (BFF) for beneesse_api codegen.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BENEESE_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
OUT="${1:-${BENEESE_ROOT}/packages/beneesse_api/openapi/openapi.yaml}"
URL="${BENEESE_OPENAPI_URL:-http://localhost:8000/openapi.yaml}"

mkdir -p "$(dirname "${OUT}")"

if curl -fsSL "${URL}" -o "${OUT}"; then
  echo "Fetched OpenAPI spec from ${URL} -> ${OUT}"
  exit 0
fi

FALLBACK="${BENEESE_OPENAPI_FALLBACK:-${BENEESE_ROOT}/../backend/openapi/openapi.yaml}"
if [[ -f "${FALLBACK}" ]]; then
  cp "${FALLBACK}" "${OUT}"
  echo "Warning: could not reach ${URL}; copied fallback ${FALLBACK} -> ${OUT}" >&2
  echo "Start the API (e.g. docker compose up) and re-run melos run generate:api to fetch from the BFF." >&2
  exit 0
fi

echo "Error: failed to fetch ${URL} and no fallback at ${FALLBACK}" >&2
echo "Start the backend, then: melos run generate:api" >&2
exit 1
