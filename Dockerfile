# Use the official nginx image to serve static content
FROM nginx:alpine

# Copy your website files (index.html, images, css, js, etc.) into nginx's default directory
COPY . /usr/share/nginx/html

# Expose the default nginx port
EXPOSE 80

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]

