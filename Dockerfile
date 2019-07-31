FROM acd-docker.repository.milieuinfo.be/node:12

ARG VERSION
ARG REPO

COPY .npmrc /root/.npmrc
COPY .gitconfig /root/.gitconfig
COPY .git-credentials /root/.git-credentials

WORKDIR /home/node/

RUN git clone ${REPO} app

WORKDIR /home/node/app

RUN npm config set proxy http://forwardproxy-pr.lb.cumuli.be:3128 \
    && npm config set https-proxy http://forwardproxy-pr.lb.cumuli.be:3128 \
    && npm install \
    && npm run release:prepare \
    && npm run release:testless -- ${VERSION}
