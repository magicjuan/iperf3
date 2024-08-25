FROM alpine as build

RUN apk add iperf3

WORKDIR /app
RUN for file in $(ldd $(which iperf3) | sed -E 's/^[^\/]*//' | cut -f1 -d' '); do \
    full_path="/app$file" \
    && mkdir -p "$(dirname $full_path)" \
    && cp "$file" "$full_path"; \
    done \
    && cp $(which iperf3) /app/ \
    && mkdir --mode=777 -p /app/tmp

FROM scratch

COPY --from=build /app /

ENTRYPOINT ["/iperf3"]
CMD ["--server"]

EXPOSE 5201
