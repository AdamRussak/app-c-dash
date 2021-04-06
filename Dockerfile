# Install dependencies
FROM python:3.9-alpine3.13

# Copy the app files to the container
COPY ./build/web/ /usr/local/bin/app

# Set the working directory to the app files within the container
WORKDIR /usr/local/bin/app

# Document the exposed port
EXPOSE 4040

# Start the web server
CMD ["python3", "-m", "http.server", "4040"]