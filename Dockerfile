FROM acd-docker.repository.milieuinfo.be/node:12

ARG VERSION
ARG REPO

ENV http_proxy=http://forwardproxy-pr.lb.cumuli.be:3128
ENV https_proxy=http://forwardproxy-pr.lb.cumuli.be:3128
ENV no_proxy=*.cumuli.be|*.mmis.be|svn.milieuinfo.be|192.168.*|10.*|127.0.0.1|localhost

COPY .npmrc /root/.npmrc
COPY .gitconfig /root/.gitconfig
COPY .git-credentials /root/.git-credentials

WORKDIR /home/node/

RUN git clone ${REPO} app

WORKDIR /home/node/app

RUN npm install \
    && npm run release:prepare \
    && npm run release:testless -- ${VERSION}
