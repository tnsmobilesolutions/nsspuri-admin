# Use a pre-built Flutter SDK image as the base image
FROM ghcr.io/cirruslabs/flutter:stable AS flutter_builder
# Set the working directory within the container
WORKDIR /app
# Copy the pubspec.yaml file to the container
COPY pubspec.yaml /app/
# Run 'flutter pub get' to install dependencies
RUN flutter pub get
# Copy the entire project to the container
COPY . /app/
# Build the Flutter web app
RUN flutter build web --web-renderer html --release
# Use the Nginx image as the final base image
FROM nginx:latest
# Copy the built Flutter web app from the 'flutter_builder' stage to Nginx's HTML directory
COPY --from=flutter_builder /app/build/web /usr/share/nginx/html
