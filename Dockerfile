FROM amazonlinux:2

ARG OKTA_OPP_VERSION=02.00.10
RUN yum update -y && \
    yum install -y https://mongodbcorp-admin.okta.com/static/agents/ProvisioningAgent/OktaProvisioningAgent-${OKTA_OPP_VERSION}.x86_64.rpm && \
    yum clean all && \
    rm -rf /var/cache/yum

USER provisioningagent
CMD ["/opt/OktaProvisioningAgent/jre/bin/java", \
     "-Dagent_home=/opt/OktaProvisioningAgent", \
     "-Xmx4096m", \
     "-jar", "/opt/OktaProvisioningAgent/bin/OktaProvisioningAgent.jar", \
     "-mode", "normal", \
     "-configFilePath", "/mnt/secrets/OktaProvisioningAgent.conf"]
