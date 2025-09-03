FROM golang:alpine
WORKDIR /app
COPY . .
RUN go mod init hello-go
RUN go mod tidy
RUN go build -o hello
CMD ["./hello"]
EXPOSE 8080
