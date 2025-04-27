# Use a lightweight web server to serve the static site
FROM nginx:alpine

# Copy static site content into the container
COPY ./dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Run the Nginx web server
CMD ["nginx", "-g", "daemon off;"]
