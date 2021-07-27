source "docker" "ubuntu" {
  image  = "ubuntu:xenial"
  commit = true
}

build {
  sources = [
    "source.docker.ubuntu"
  ]
}