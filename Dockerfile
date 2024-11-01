# Step : Use httpd official image
FROM httpd:latest


# Step 2: Copy your web app (HTML/CSS files) to the appropriate location inside the Apache container
COPY index.html /usr/local/apache2/htdocs/
COPY style.css /usr/local/apache2/htdocs/
COPY images /usr/local/apache2/htdocs/images
#COPY /C/Users/brendon/Documents/Development/Cloud/Devops/Projects/lab1/repo/website-abc.com/index.html /usr/local/apache2/htdocs/
#COPY /C/Users/brendon/Documents/Development/Cloud/Devops/Projects/lab1/repo/website-abc.com/style.css /usr/local/apache2/htdocs/
#COPY /C/Users/brendon/Documents/Development/Cloud/Devops/Projects/lab1/repo/website-abc.com/images /usr/local/apache2/htdocs/

# Expose port 80 for the web server
EXPOSE 80

# Start the Apache server in the foreground
CMD ["httpd-foreground"]
