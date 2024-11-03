FROM raspbian/jessie

ADD sources.list /etc/apt/sources.list
RUN apt update
RUN apt upgrade -y
ENV DEBIAN_FRONTEND noninteractive
RUN apt install -y cups usbutils
ADD ql700pdrv-2.1.4-0.armhf.deb /home/pi/Downloads/ql700pdrv-2.1.4-0.armhf.deb
RUN dpkg -i /home/pi/Downloads/ql700pdrv-2.1.4-0.armhf.deb
ADD cupsd.conf /etc/cups/cupsd.conf
ADD printers.conf /etc/cups/printers.conf
ADD QL-700.ppd /etc/cups/ppd/QL-700.ppd
ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN usermod -aG lp root
RUN usermod -aG lpadmin root
RUN chmod og+w /tmp
RUN chown root:lp /etc/cups/ppd/QL-700.ppd
ENTRYPOINT /usr/local/bin/entrypoint.sh
