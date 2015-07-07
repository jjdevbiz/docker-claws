# claws-mail over ssh X11Forwarding

FROM	debian:stable

# make sure the package repository is up to date
# and blindly upgrade all packages
RUN	apt-get update
RUN	apt-get upgrade -y

# install ssh and iceweasel
RUN	apt-get install -y openssh-server
RUN	apt-get install -y claws-mail claws-mail-archiver-plugin claws-mail-address-keeper claws-mail-clamd-plugin claws-mail-extra-plugins claws-mail-fancy-plugin claws-mail-pdf-viewer claws-mail-pgpinline claws-mail-pgpmime claws-mail-plugins claws-mail-spamassassin claws-mail-themes

# Create user "docker" and set the password to "docker"
RUN useradd -m -d /home/docker docker
RUN echo "docker:docker" | chpasswd

# Prepare ssh config folder
RUN mkdir -p /home/docker/.ssh
RUN chown -R docker:docker /home/docker
RUN chown -R docker:docker /home/docker/.ssh

# Create OpenSSH privilege separation directory, enable X11Forwarding
RUN mkdir -p /var/run/sshd
RUN echo X11Forwarding yes >> /etc/ssh/ssh_config

# Expose the SSH port
EXPOSE 22

# Start SSH
ENTRYPOINT ["/usr/sbin/sshd",  "-D"]
