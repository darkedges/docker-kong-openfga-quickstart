# # Stage 1: compile the Artifactory terraform provider
FROM busybox:1.36 AS builder

# VAULT provider
ARG KONG_PROVIDER_VERSION=6.630.0
WORKDIR /src/plugins/registry.terraform.io/philips-labs/kong/${KONG_PROVIDER_VERSION}/linux_amd64/
ADD https://github.com/philips-labs/terraform-provider-kong/releases/download/v${KONG_PROVIDER_VERSION}/terraform-provider-kong_${KONG_PROVIDER_VERSION}_linux_amd64.zip terraform-provider-kong_${KONG_PROVIDER_VERSION}_linux_amd64.zip
RUN unzip terraform-provider-kong_${KONG_PROVIDER_VERSION}_linux_amd64.zip && \
    rm -f terraform-provider-kong_${KONG_PROVIDER_VERSION}_linux_amd64.zip

# openFGA Provider
ARG OPENFGA_PROVIDER_VERSION=0.3.2
WORKDIR /src/plugins/registry.terraform.io/mauriceackel/openfga/${OPENFGA_PROVIDER_VERSION}/linux_amd64/
ADD https://github.com/mauriceackel/terraform-provider-openfga/releases/download/v${OPENFGA_PROVIDER_VERSION}/terraform-provider-openfga_${OPENFGA_PROVIDER_VERSION}_linux_amd64.zip terraform-provider-openfga_${OPENFGA_PROVIDER_VERSION}_linux_amd64.zip
RUN unzip terraform-provider-openfga_${OPENFGA_PROVIDER_VERSION}_linux_amd64.zip && \
    rm -f terraform-provider-openfga_${OPENFGA_PROVIDER_VERSION}_linux_amd64.zip

# Stage 2: build hashicorp/terraform image with providers baked in
FROM hashicorp/terraform:1.9.5

# Install requirements via Artifactory alpine mirror
RUN apk add --no-cache jq curl libcurl

# Copy Terraform provider binaries from first stage
COPY --from=builder /src/plugins/registry.terraform.io/ /terraform.d/plugins/registry.terraform.io/
COPY scripts/init-kong.sh /init-kong.sh

# Checkpoint itself can be entirely disabled for all HashiCorp products
# RUN echo 'disable_checkpoint = true' > /root/.terraformrc
ENV CHECKPOINT_DISABLE=1

ENV TF_DATA_DIR=/mnt/terraform/data

ENV TF_CLI_ARGS_init="-plugin-dir=/terraform.d/plugins"

COPY init/* /mnt/init/

