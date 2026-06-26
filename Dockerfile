FROM golang:1.22.5 AS builder

WORKDIR /app
COPY go.mod ./

RUN go mod download
COPY . .
RUN go build -o swagat .

FROM gcr.io/distroless/base
WORKDIR /app
COPY --from=builder /app/swagat .
COPY --from=builder /app/static ./static
EXPOSE 8080
CMD ["./swagat"]