source "docker" "ubuntu" {
  image  = "ubuntu"
  commit = true
  /*
    changes = [
      "USER www-data",
      "WORKDIR /var/www",
      "ENV HOSTNAME www.example.com",
      "VOLUME /test1 /test2",
      "EXPOSE 80 443",
      "LABEL version=1.0",
      "ONBUILD RUN date",
      "CMD [\"nginx\", \"-g\", \"daemon off;\"]",
      "ENTRYPOINT /var/www/start.sh"
    ]
  */
}

build {
  sources = ["source.docker.ubuntu"]
}