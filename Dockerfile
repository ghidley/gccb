FROM centos:7
# When running using docker daemon on hpwren server, remove comments ...
#RUN useradd -r -u 1234??? -g hpwren hpwren
#USER hpwren

Run yum clean all ; yum -y update
RUN yum -y install perl ImageMagick netpbm netpbm-progs mlocate perl-App-cpanminus
RUN cpanm Proc::Reliable
RUN yum -y install git
#RUN git clone --single-branch https://github.com/ghidley/getcams.git /opt/getcams
COPY getcams /opt/getcams
COPY config_getcams_vars-cb /opt/getcams/config_getcams_vars
COPY config_runcam_vars-cb /opt/getcams/config_runcam_vars
COPY cam_access /opt/getcams
COPY cam_params-cb /opt/getcams/cam_params
WORKDIR /opt/getcams
# Inject config files here ...
#ENTRYPOINT ["/run_cameras"]
#CMD ["-I"]
