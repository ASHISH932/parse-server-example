FROM node:10.16.1

RUN mkdir parse

ADD . /parse
WORKDIR /parse
RUN npm install

RUN node obfuscate.js
RUN rm index.js obfuscate.js && mv index-obfuscated.js index.js
RUN rm ./cloud/main.js && mv ./cloud/main-obfuscated.js ./cloud/main.js

ENV APP_ID setYourAppId
ENV MASTER_KEY setYourMasterKey
ENV DATABASE_URI setMongoDBURI
ENV SYSDIG_AGENT_CONF 'app_checks: [{name: node, check_module: prometheus, pattern: {comm: node}, conf: { url: "http://localhost:{port}/metrics" }}]'

# Optional (default : 'parse/cloud/main.js')
# ENV CLOUD_CODE_MAIN cloudCodePath

# Optional (default : '/parse')
# ENV PARSE_MOUNT mountPath

EXPOSE 1337

# Uncomment if you want to access cloud code outside of your container
# A main.js file must be present, if not Parse will not start

# VOLUME /parse/cloud

CMD ["npm", "start"]
