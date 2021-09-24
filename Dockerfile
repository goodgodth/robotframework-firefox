FROM centos:centos7
MAINTAINER Mr.Ar-ruk Kachen
LABEL description Robot Framework with Firefox in Docker.
# Reference from ppodgorsek/docker-robot-framework
# Dependency versions
ENV DATABASE_LIBRARY_VERSION 1.2
ENV FAKER_VERSION 4.2.0
ENV FTP_LIBRARY_VERSION 1.6
ENV GECKO_DRIVER_VERSION v0.30.0
ENV PABOT_VERSION 0.89
ENV REQUESTS_VERSION 0.6.2
ENV ROBOT_FRAMEWORK_VERSION 3.1.2
ENV SELENIUM_LIBRARY_VERSION 4.1.0
ENV SELENIUM2_LIBRARY_VERSION 3.0.0
ENV SSH_LIBRARY_VERSION 3.4.0
ENV XVFB_VERSION 1.20

RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum -y install wget telnet x11vnc firefox xorg-x11-server-Xvfb xorg-x11-twm tigervnc-server xterm xorg-x11-font dejavu-sans-fonts dejavu-serif-fonts xdotool; yum clean all

RUN yum install -y python3
RUN ln -fs /usr/bin/python3 /usr/bin/python
RUN ln -fs /usr/bin/pip3.6 /usr/bin/pip

RUN python --version
RUN pip install --upgrade pip
RUN pip install \
    --no-cache-dir \
    robotframework==$ROBOT_FRAMEWORK_VERSION \
    robotframework-databaselibrary==$DATABASE_LIBRARY_VERSION \
    robotframework-faker==$FAKER_VERSION \
    robotframework-ftplibrary==$FTP_LIBRARY_VERSION \
    robotframework-pabot==$PABOT_VERSION \
    robotframework-requests==$REQUESTS_VERSION \
    robotframework-seleniumlibrary==$SELENIUM_LIBRARY_VERSION \
    robotframework-selenium2library==$SELENIUM2_LIBRARY_VERSION \
    robotframework-sshlibrary==$SSH_LIBRARY_VERSION \
    PyYAML
RUN pip list
RUN wget https://github.com/mozilla/geckodriver/releases/download/$GECKO_DRIVER_VERSION/geckodriver-$GECKO_DRIVER_VE
RSION-linux64.tar.gz
RUN mkdir -p /opt/robotframework/drivers/
RUN tar xvf geckodriver-$GECKO_DRIVER_VERSION-linux64.tar.gz -C /opt/robotframework/drivers/
# Update system path
ENV PATH=/opt/robotframework/bin:/opt/robotframework/drivers:$PATH
#RUN firefox -v
#RUN robot --version
#RUN geckodriver -v
