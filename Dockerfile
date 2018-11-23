FROM golang:latest as build

ENV GOPATH=/go
ENV PATH=$GOPATH/bin:$PATH
ENV CGO_ENABLED 0
ENV GO111MODULE on

RUN mkdir -p /go/{src,bin,pkg}

ADD . /go/src/git.pepabo.com/takaishi/noguard_sg_checker
WORKDIR /go/src/git.pepabo.com/takaishi/noguard_sg_checker
RUN go get
RUN go build

FROM rtakaishi/clon as app
WORKDIR /
COPY --from=build /go/src/git.pepabo.com/takaishi/noguard_sg_checker/noguard_sg_checker /noguard_sg_checker

ENTRYPOINT ["/noguard_sg_checker", "--config", "/config.toml"]