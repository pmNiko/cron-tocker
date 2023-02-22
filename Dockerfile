# Dependencias de desarrollo
FROM node:19.2-alpine3.17 as devDeps
WORKDIR /app
COPY package.json ./
RUN npm install 

# Test Runner
FROM node:19.2-alpine3.17 as testRunner
WORKDIR /app
COPY --from=devDeps /app/node_modules ./node_modules
COPY . . 
RUN npm run test

# Dependencias de Producción
FROM node:19.2-alpine3.17 as devProd
WORKDIR /app
COPY --from=testRunner /app/package.json package.json
RUN npm install --prod


# App Runner
FROM node:19.2-alpine3.17 as runner
WORKDIR /app
COPY --from=devProd /app/node_modules ./node_modules
COPY app.js .
COPY tasks/ ./tasks
CMD [ "node", "app.js" ]



