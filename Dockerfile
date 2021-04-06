# Install dependencies
FROM python:3.9-alpine3.13
# FROM python:3.9.4-slim-buster
RUN apk add --no-cache bash
# Copy the app files to the container
COPY ./build/web/ /usr/local/bin/app
COPY server.sh /usr/local/bin/app

# Set the working directory to the app files within the container
WORKDIR /usr/local/bin/app

# Document the exposed port
EXPOSE 4040

# Start the web server
CMD ["python3", "-m", "http.server", "4040"]