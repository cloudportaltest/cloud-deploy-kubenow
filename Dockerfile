FROM python:2.7-alpine
MAINTAINER "Anders Larsson <anders.larsson@icm.uu.se>"

# Provisioners versions
ENV TERRAFORM_VERSION=0.9.8
ENV TERRAFORM_SHA256SUM=f951885f4e15deb4cf66f3b199964e3e74a0298bb46c9fe42e105df2ebcf3d16
ENV ANSIBLE_VERSION=2.3.1.0
ENV LIBCLOUD_VERSION=1.5.0
ENV J2CLI_VERSION=0.3.1.post0
ENV DNSPYTHON_VERSION=1.15.0
ENV JMESPATH_VERSION=0.9.3
ENV SHADE_VERSION=1.21.0
ENV OPENSTACKCLIENT_VERSION=3.11.0

# Install APK deps
RUN apk add --update --no-cache \
  git \
  curl \
  openssh \
  build-base \
  linux-headers \
  libffi-dev \
  openssl-dev \
  openssl \
  bash \
  su-exec \
  apache2-utils \
  libvirt

# Install PIP deps
RUN pip install \
  ansible=="$ANSIBLE_VERSION" \
  j2cli=="$J2CLI_VERSION" \
  dnspython=="$DNSPYTHON_VERSION" \
  jmespath=="$JMESPATH_VERSION" \
  apache-libcloud=="$LIBCLOUD_VERSION" \
  shade=="$SHADE_VERSION"

# Install Terraform
RUN curl "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > \
    "terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
    echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > \
    "terraform_${TERRAFORM_VERSION}_SHA256SUMS" && \
    sha256sum -c "terraform_${TERRAFORM_VERSION}_SHA256SUMS" && \
    unzip "terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -d /bin && \
    rm -f "terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
    
# Add libvirt plugin to Terraform
RUN mkdir "/terraform_plugins/"
RUN curl "https://github.com/andersla/terraform-provider-libvirt/blob/develop/andersla/bin/terraform-provider-libvirt" \
         -o "/terraform_plugins/terraform-provider-libvirt"
RUN chmod +x "/terraform_plugins/terraform-provider-libvirt"
RUN echo 'providers { libvirt = "/terraform_plugins/terraform-provider-libvirt" }' > "/.terraformrc"

# Copy script
COPY bin/docker-entrypoint-v2 /

# Set entrypoint
ENTRYPOINT ["/docker-entrypoint-v2"]
