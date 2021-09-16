FROM centos:7
# Vers. 061021
# When running using docker daemon on hpwren server, remove comments if needed ...
#RUN useradd -r -u 1234??? -g hpwren hpwren
#USER hpwren

WORKDIR /opt/getcams
Run yum clean all ; yum -y update
RUN yum -y install perl ImageMagick netpbm netpbm-progs mlocate perl-App-cpanminus
RUN cpanm Proc::Reliable
RUN yum -y install git
RUN yum -y install http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
RUN yum -y install perl-Image-ExifTool
#RUN git clone --single-branch https://github.com/ghidley/getcams.git /opt/getcams
COPY getcams hosts-cb /opt/getcams
COPY config_getcams_vars-cb /opt/getcams/config_getcams_vars
COPY config_runcam_vars-cb /opt/getcams/config_runcam_vars
COPY Makefile-cb /opt/getcams/Makefile
COPY cam_access /opt/getcams
COPY cam_params-cb /opt/getcams/cam_params
ENV RHOME="/opt/getcams"
ENV RPATH="/opt/getcams"
ENV TZ="America/Los_Angeles"
COPY entry_commands.sh docker-entrypoint.sh /opt/getcams
ENTRYPOINT ["./docker-entrypoint.sh", "./run_cameras"]
CMD ["-I"]
