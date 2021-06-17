#Build stage
FROM fpco/stack-build:lts-16.11 as build

RUN export PATH=$(stack path --local-bin):$PATH
RUN mkdir -p /opt/build
WORKDIR /opt/build

COPY stack.yaml .
COPY docker-test.cabal .
RUN stack build --only-dependencies --system-ghc --fast

COPY . /opt/build/
RUN stack install

# Deploy stage
FROM ubuntu

WORKDIR /opt/build
COPY --from=build /root/.local/bin/docker-test-exe .

CMD /opt/build/docker-test-exe
