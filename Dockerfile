FROM openshift/wildfly-150-centos7:latest
# Base Dockerfile: https://github.com/openshift-s2i/s2i-wildfly/blob/master/15.0/Dockerfile

LABEL maintainer="Jorge Morales, Jean Francois Denise, Alexey Loubyansky"

LABEL io.k8s.description="Platform for building EE applications and Wildfly servers using Wildfly Galleon" \
      io.k8s.display-name="Wildfly Galleon S2I builder 1.0" \
      io.openshift.expose-services="8080:http, 9090:http" \
      io.openshift.tags="builder,java-8,maven-3,wildfly,wildfly-galleon"

USER root

ENV GALLEON_VERSION=3.0.2.Final
RUN curl -sL -0 https://github.com/wildfly/galleon/releases/download/${GALLEON_VERSION}/galleon-${GALLEON_VERSION}.zip -o /tmp/galleon-${GALLEON_VERSION}.zip && \
    unzip /tmp/galleon-${GALLEON_VERSION}.zip -d /usr/local/ && \
    rm /tmp/galleon-${GALLEON_VERSION}.zip && \
    mv /usr/local/galleon-${GALLEON_VERSION} /usr/local/galleon && \
    ln -sf /usr/local/galleon/bin/galleon.sh /usr/local/galleon/bin/galleon

ENV PATH=/usr/local/galleon/bin:$PATH

# COPY Additional files,configurations that we want to ship by default, like a default setting.xml
# s2i path set in base image via LABEL: /usr/local/s2i
RUN cp -prf $STI_SCRIPTS_PATH /usr/local/s2i-original
COPY ./sti/bin/ $STI_SCRIPTS_PATH
# ENV S2I_SOURCE_DEPLOYMENTS_FILTER=*.war

# Outputs will be left under this directory
RUN mkdir -p /output/deployments && mkdir -p /output/wildfly && \
    chown -R 1001:0 /output && chmod -R ug+rwX /output

# This default user is created in the base java image
USER 1001

# Set additional port to be exposed (8080 and 8443 already exported in base image)
EXPOSE 9090

CMD ["usage"]
