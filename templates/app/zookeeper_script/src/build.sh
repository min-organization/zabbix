#build on darwin for linux
CGO_ENABLED=0 CC=x86_64-linux-musl-gcc CXX=x86_64-linux-musl-g++ GOOS=linux GOARCH=amd64 go build -ldflags '-s -w -extldflags "-static -fPIC"' -trimpath
