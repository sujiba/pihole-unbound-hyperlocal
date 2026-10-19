DATE = formatdate("YYYY.MM.DD", timestamp())
APP = "pihole-unbound-hyperlocal"
SOURCE = "https://github.com/pi-hole/docker-pi-hole"
variable "GIT_SHA" {}
variable "REPO_URL" { default = "" }

variable "VERSION" {
  default = "2026.10.0"
}

group "default" {
  targets = ["image-local"]
}

target "image" {
  inherits = ["docker-metadata-action"]
  args = {
    VERSION = "${VERSION}"
  }
  labels = {
    "org.opencontainers.image.vendor" = "sujiba"
    "org.opencontainers.image.source" = "${REPO_URL}"
    "org.opencontainers.image.created" = "${DATE}"
    "org.opencontainers.image.revision" = "${GIT_SHA}"
    "org.opencontainers.image.title" = "${APP}"
    "org.opencontainers.image.url" = "${SOURCE}"
    "org.opencontainers.image.version" = "${VERSION}"
  }
  no-cache = true
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
  tags = ["${APP}:${VERSION}"]
}

REGISTRIES = ["ghcr.io/sujiba", "docker.io/sujiba"]

target "image-all" {
  inherits = ["image"]
  platforms = [
    "linux/amd64",
    "linux/arm64",
    "linux/arm/v7",
    "linux/arm/v6",
  ]
  tags = flatten([
    for reg in REGISTRIES : [
      "${reg}/${APP}:sha-${GIT_SHA}",
      "${reg}/${APP}:${VERSION}",
      "${reg}/${APP}:latest",
    ]
  ])
}

target "image-dev" {
  inherits = ["image-all"]
  tags = flatten([
    for reg in REGISTRIES : [
      "${reg}/${APP}:sha-${GIT_SHA}",
      "${reg}/${APP}:${VERSION}-dev",
      "${reg}/${APP}:dev",
    ]
  ])
}

target "docker-metadata-action" {}
