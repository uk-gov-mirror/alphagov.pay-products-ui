FROM node:12.22.1-alpine3.12@sha256:8dea8474e2072f9f2fc47d29252fb7dfef34194501fef5a8ff61ed3f55ebdbb0

### Needed to run appmetrics and pact-mock-service
COPY sgerrand.rsa.pub /etc/apk/keys/sgerrand.rsa.pub
RUN ["apk", "--no-cache", "add", "ca-certificates"]
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk && apk add --no-cache glibc-2.28-r0.apk && rm -f glibc-2.28-r0.apk
###

RUN ["apk", "--no-cache", "upgrade"]

RUN ["apk", "add", "--no-cache", "bash", "make", "g++", "python2", "git", "ruby"]

ENV PORT 9000
EXPOSE 9000

ADD package.json /tmp/package.json
ADD package-lock.json /tmp/package-lock.json
RUN cd /tmp && npm install --production

WORKDIR /app
ADD . /app

RUN ["ln", "-s", "/tmp/node_modules", "/app/node_modules"]
ENV LD_LIBRARY_PATH /app/node_modules/appmetrics
CMD ["npm", "start"]
