FROM fedora:latest
 
# Upgrade base image and install required tools
RUN dnf -y upgrade && \
    dnf -y install tuxpaint vim httpd && \
    dnf clean all
 
# Copy the page into Apache web root
COPY myinfo.html /var/www/html/my-info.html
 
# Prepare Apache and enable at boot where systemd exists
RUN mkdir -p /run/httpd && \
    systemctl enable httpd || true
 
# Expose port 80
EXPOSE 80
 
# Run httpd in the foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]