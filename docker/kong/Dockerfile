FROM kong:3.9

WORKDIR /usr/kong/

# switch to root to install opa plugin and rocks in /usr/local
USER root

#install dependencies
RUN apt-get update && \
    apt-get install -y gcc libc-dev curl && \
    luarocks install lua-cjson && \
    luarocks install lua-resty-jwt

# Install OPA plugin
RUN git clone https://github.com/open-policy-agent/contrib &&\
    mv contrib/kong_api_authz /usr/kong/opa/ &&\
    rm -rf contrib
RUN git clone https://github.com/darkedges/kong-plugin-ping-auth &&\
    mv kong-plugin-ping-auth/ping-auth /usr/kong/ping-auth/ &&\
    rm -rf kong-plugin-ping-auth

WORKDIR /usr/kong/opa

# build and install the opa plugin
RUN luarocks make

# Install Ping Auth plugin
WORKDIR /usr/kong/ping-auth
# build and install the ping-auth plugin
RUN luarocks make

# Install OpenFGA Plugin
RUN luarocks install kong-plugin-kong-authz-openfga

WORKDIR /usr/kong/

#install phantom-token plugin
RUN git config --global url."https://".insteadOf git:// && \
    git config --global advice.detachedHead false && \
    luarocks install kong-phantom-token 2.0.1

# back to kong user
USER kong