# Use Node 16 to ensure compatibility with your MERN project
FROM node:16-slim

ARG NODE_OPTIONS

# Set the working directory inside the container
WORKDIR /app

# Copy package files first to optimize build speed
COPY package*.json ./

# Install dependencies for the backend
RUN npm install

# Copy the rest of your application code
COPY . .

# Move into the frontend folder, install its dependencies, and build it
RUN cd frontend && npm install && npm run build

# Expose the port your backend runs on
EXPOSE 5000

# Start the application
CMD ["npm", "start"]
