# Multi-stage: official Xray image has no shell, so copy the binary into Alpine
FROM ghcr.io/xtls/xray-core:latest AS xray
FROM alpine:3.20
RUN apk add --no-cache ca-certificates
COPY --from=xray /usr/bin/xray /usr/bin/xray
COPY config.template.json /etc/xray/config.template.json
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 3000
CMD ["/entrypoint.sh"]
