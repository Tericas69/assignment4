# Base image
FROM fedora:latest

# update  andinstall required packages
RUN dnf -y update && \
dnf install -y tuxpaint vim httpg && \
dnf clean all

# Copy the page into Apache web root 
COPY my-info.html /var/www/html/my-info.html
VOLUME ["/var/www/html/data"]



# Expose port 80 for documentation purposes
EXPOSE 80

# Run httpd in the foreground so the container stays up 
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
 
# Upgrade the base image and install required tools
RUN dnf -y upgrade && \
    dnf -y install tuxpaint vim httpd && \
    dnf clean all
 
# Copy the local file named "myinfo.html" into the container path requested
COPY myinfo.html /var/www/html/my-info.html
 
# Prepare Apache run directory and try to enable at boot when systemd is present
# The "|| true" keeps the build from failing outside a systemd environment
RUN mkdir -p /run/httpd && \
    systemctl enable httpd || true
 
# Expose HTTP
EXPOSE 80
 
# Ensure httpd runs when the container starts
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]