FROM kanidm/tools:latest as kanidm-tools

FROM golang:latest AS go-builder

WORKDIR /app

RUN GOBIN=/app CGO_ENABLED=0 go install github.com/miguelangel-nubla/ruckus-dpsk-manager@latest

FROM ghcr.io/miguelangel-nubla/o2wa:latest

RUN apt-get update && apt-get install -y expect && rm -rf /var/lib/apt/lists/*

COPY --from=go-builder /app/ruckus-dpsk-manager /bin/ruckus-dpsk-manager
COPY --from=kanidm-tools /usr/sbin/kanidm /bin/kanidm
