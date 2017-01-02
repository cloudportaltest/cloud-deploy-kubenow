#
# These vars are expected to be set in web-ui (specified via manifest.sh)
#

#
# All credentials env vars from openstack are expected
#
# OS_AUTH_URL
# OS_TENANT_ID
# OS_TENANT_NAME
# OS_USERNAME
# OS_PASSWORD
# OS_REGION_NAME
# OS_USER_DOMAIN_ID
# OS_DOMAIN_ID
# OS_PROJECT_ID
# OS_AUTH_VERSION

#
# Speciffic for Embassy openstack
#
export TF_VAR_floating_ip_pool="net_external"
export TF_VAR_external_network_uuid="d9384930-baa5-422b-8657-1d42fb54f89c"

#
# General (flavor names are speciffic for each openstack installation)
#
export TF_VAR_master_flavor="s1.large"
export TF_VAR_node_flavor="s1.large"
export TF_VAR_edge_flavor="s1.large"

export TF_VAR_cluster_prefix="vrembassy"
export TF_VAR_node_count="2"
export TF_VAR_edge_count="2"

#
# General for TSI
#
export PORTAL_DEPLOYMENTS_ROOT="/home/xxxxxxxxxxxx/cloud-deploy/deployments"
export PORTAL_APP_REPO_FOLDER="/home/xxxxxxxxxx/cloud-deploy"
export PORTAL_DEPLOYMENT_REFERENCE="id-phnmnl-embassy"

# local testing - make sure deploymend id dir exists
mkdir $PORTAL_DEPLOYMENTS_ROOT'/'$PORTAL_DEPLOYMENT_REFERENCE