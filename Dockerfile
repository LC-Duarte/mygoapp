# Use the official Golang image as a base
FROM golang:1.17-alpine AS builder
# Set the working directory
WORKDIR /mygoapp
# Copy the Go module files and download dependencies
COPY go.mod go.sum ./
RUN go mod download
# Copy the rest of the application source code
COPY . .
# Build the application
RUN go build -o /mygoapp cmd/mygoapp/main.go
# Use a minimal Alpine-based image to reduce the final image size
FROM alpine:3.14
# Set the working directory
WORKDIR /mygoapp
# Copy the server binary from the builder image
COPY --from=builder /mygoapp .
# Expose the server port
EXPOSE 8080
# Start the server
CMD ["./mygoapp"]