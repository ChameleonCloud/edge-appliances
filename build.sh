#!/usr/bin/env bash
set -e -u -o pipefail
namespace="${DOCKER_NAMESPACE:-chameleoncloud}"
registry="${DOCKER_REGISTRY:-}"
target=
tag=
push=
declare -a docker_build=(docker build)

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --tag)
      tag="$2"
      shift
      ;;
    --build-arg)
      docker_build+=(--build-arg "$2")
      shift
      ;;
    --push)
      push="yes"
      ;;
    *)
      target="$1"
      ;;
  esac
  shift
done

if [[ ! -f "$target" ]]; then
  echo "$target is not a valid Dockerfile"
  exit 1
fi
docker_build+=(--file "$target")

if [[ "$(arch)" == "i386" ]]; then
  docker_build+=(--platform linux/arm)
fi

docker_build+=(--build-arg "namespace=${namespace}")
if [[ "${registry}" ]]; then
  docker_build+=(--build-arg "docker_registry=${registry}/")
fi

repo="${target/\//-}"
repo="${repo%.Dockerfile}"
repo="${namespace}/${repo}"
tag="$repo:${tag:-latest}"
docker_build+=(--tag "$tag")

docker_build+=("$(dirname "$target")")

echo "${docker_build[@]}"
"${docker_build[@]}"

if [[ -n "$registry" ]]; then
  registry_tag="${registry}/${tag}"
  docker tag "$tag" "${registry}/${tag}"
  tag="${registry_tag}"
  echo "Tagged as ${registry_tag}"
fi

if [[ "$push" == "yes" ]]; then
  docker push "$tag"
fi
