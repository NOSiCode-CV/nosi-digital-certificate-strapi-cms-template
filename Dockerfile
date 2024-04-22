FROM public.ecr.aws/docker/library/node:20-alpine

# Installing libvips-dev for sharp compatability
RUN apk add --no-cache libc6-compat

#ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

# Strapi port
ENV PORT 4444

# Create app directory
WORKDIR /opt/

# Installing dependencies
COPY ./package*.json ./
COPY ./yarn.lock ./

ENV PATH /opt/node_modules/.bin:$PATH
RUN yarn config set network-timeout 600000 -g
RUN yarn install

# Copying source files
WORKDIR /opt/app
COPY ./ .

# Building app
RUN yarn build
EXPOSE 4444

# Running the app
CMD ["yarn", "start"]
#CMD ["node", "server.js"]