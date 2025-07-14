#!/bin/bash
set -xeu -o pipefail

REPO="quay.io/dwinchell_redhat/bogohttp"
VERSIONS=("v1" "v2")
PLATFORMS=("linux/amd64" "linux/ppc64le")

echo "Building and pushing architecture-specific images ..."

for version in "${VERSIONS[@]}"; do
  for platform in "${PLATFORMS[@]}"; do

    ARCH=$(echo "$platform" | cut -d '/' -f2)
    SINGLE_ARCH_TAG="${REPO}:${version}.${ARCH}"
    INDEX_FILE="index.html.${version}"

    echo "Building image - platform: ${platform}, index.html: ${INDEX_FILE}, tag: ${SINGLE_ARCH_TAG} ..."
    podman build \
      --platform "$platform" \
      -t "$SINGLE_ARCH_TAG" \
      --build-arg INDEX_FILE="${INDEX_FILE}" \
      .
    echo "Successfully built ${SINGLE_ARCH_TAG}."

    echo "Pushing image ..."
    podman push ${SINGLE_ARCH_TAG}
    echo "Successfully pushed ${SINGLE_ARCH_TAG}."

  done
done

echo "All individual architecture images built and pushed."

echo "Creating multi-architecture manifest lists ..."


for version in "${VERSIONS[@]}"; do

  MULTI_ARCH_TAG="${REPO}:${version}"

  podman manifest rm "${MULTI_ARCH_TAG}" || true
  podman manifest create "${MULTI_ARCH_TAG}"

  for platform in "${PLATFORMS[@]}"; do

    ARCH=$(echo "$platform" | cut -d '/' -f2)
    SINGLE_ARCH_TAG="${REPO}:${version}.${ARCH}"

    podman manifest add "${MULTI_ARCH_TAG}" "${SINGLE_ARCH_TAG}"
  done

  echo "Pushing multi-architecture manifest list ${MULTI_ARCH_TAG} ..."
  podman push ${MULTI_ARCH_TAG}
done

echo "Done."

