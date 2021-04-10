FROM centos:7
# When running using docker daemon on hpwren server, remove comments ...
#RUN useradd -r -u 1234??? -g hpwren hpwren
#USER hpwren

WORKDIR /opt/getcams
Run yum clean all ; yum -y update
RUN yum -y install perl ImageMagick netpbm netpbm-progs mlocate perl-App-cpanminus
RUN cpanm Proc::Reliable
RUN yum -y install git
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
# Inject config files here ...
ENTRYPOINT ["/bin/sh", "-c", \
	"cat /opt/getcams/hosts-cb >> /etc/hosts && \
	mkdir scratch && s\
	leep infinity"]
#ENTRYPOINT ["/bin/sh, "-c", "cat /opt/getcams/hosts-cb >> /etc/hosts" && exec /run_cameras"]
#ENTRYPOINT ["/run_cameras"]
#CMD ["-I"]
#RUN cat /opt/getcams/hosts-cb >> /etc/hosts
