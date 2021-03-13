FROM centos:7

Run yum clean all ; yum -y update
RUN yum -y install perl ImageMagick netpbm netpbm-progs mlocate perl-App-cpanminus
RUN cpanm Proc::Reliable
RUN yum -y install git
RUN git clone --single-branch https://github.com/ghidley/getcams.git /opt/getcams
WORKDIR /opt/getcams
