# ----------------------------------------------------------------------
# GENERAL
# ----------------------------------------------------------------------

variable "cluster_name" {
  type        = string
  description = "Desired name of new cluster"
}

variable "cluster_description" {
  type        = string
  description = "Description of what cluster is for"
  default     = ""
}

variable "write_ssh_files" {
  type        = bool
  description = "Write out the files to ssh into cluster"
  default     = false
}

variable "write_kubeconfig_files" {
  type        = bool
  description = "Write out the kubeconfig for devops user"
  default     = false
}

# ----------------------------------------------------------------------
# OPENSTACK
# ----------------------------------------------------------------------

variable "openstack_url" {
  type        = string
  description = "OpenStack URL"
  default     = "https://radiant.ncsa.illinois.edu:5000/v3/"
}

variable "openstack_credential_id" {
  type        = string
  sensitive   = true
  description = "Openstack credentials"
}

variable "openstack_credential_secret" {
  type        = string
  sensitive   = true
  description = "Openstack credentials"
}

variable "openstack_external_net" {
  type        = string
  description = "OpenStack external network"
  default     = "ext-net"
}

# ----------------------------------------------------------------------
# KUBERNETES NODES
# ----------------------------------------------------------------------

# curl -s https://releases.rancher.com/kontainer-driver-metadata/release-v2.6/data.json | jq -r '.K8sVersionRKESystemImages | keys'
variable "rke1_version" {
  type        = string
  description = "Version of rke1 to install."
  default     = "v1.21.14-rancher1-1"
}

variable "old_hostnames" {
  type        = bool
  description = "should old hostname be used (base 0)"
  default     = false
}

variable "controlplane_count" {
  type        = string
  description = "Desired quantity of control-plane nodes"
  default     = 3
}

variable "controlplane_flavor" {
  type        = string
  description = "Desired flavor of control-plane nodes"
  default     = "m1.medium"
}

variable "controlplane_disksize" {
  type        = string
  description = "Desired disksize of control-plane nodes"
  default     = 40
}

variable "worker_count" {
  type        = string
  description = "Desired quantity of worker nodes"
  default     = 3
}

variable "worker_flavor" {
  type        = string
  description = "Desired flavor of worker nodes"
  default     = "m1.large"
}

variable "worker_disksize" {
  type        = string
  description = "Desired disksize of worker nodes"
  default     = 40
}

# ----------------------------------------------------------------------
# RANCHER
# ----------------------------------------------------------------------
variable "rancher_url" {
  type        = string
  description = "URL where rancher runs"
  default     = "https://gonzo-rancher.ncsa.illinois.edu"
}

variable "rancher_token" {
  type        = string
  sensitive   = true
  description = "Access token for rancher, clusters are created as this user"
}

# ----------------------------------------------------------------------
# USERS
# ----------------------------------------------------------------------

variable "admin_radiant" {
  type        = bool
  description = "Should users that have access to radiant be an admin"
  default     = true
}

variable "admin_users" {
  type        = set(string)
  description = "Should argocd be used for infrastructure"
  default     = []
}

variable "admin_groups" {
  type        = set(string)
  description = "Should argocd be used for infrastructure"
  default     = []
}

variable "member_users" {
  type        = set(string)
  description = "Should argocd be used for infrastructure"
  default     = []
}

variable "member_groups" {
  type        = set(string)
  description = "Should argocd be used for infrastructure"
  default     = []
}

# ----------------------------------------------------------------------
# ARGOCD
# ----------------------------------------------------------------------
variable "argocd_master" {
  type        = bool
  description = "Is this the master argocd cluster, you most likely don't need to modify this value"
  default     = false
}

variable "argocd_enabled" {
  type        = bool
  description = "Should argocd resources be created"
  default     = true
}

variable "argocd_sync" {
  type        = bool
  description = "Should apps automatically sync"
  default     = false
}

variable "argocd_annotations" {
  type        = set(string)
  description = "Send notifications in case anything changes."
  default     = []
}

variable "argocd_kube_id" {
  type        = string
  description = "Rancher kube id for argocd cluster"
  default     = "c-p9m26"
}

# ----------------------------------------------------------------------
# APPLICATIONS (some rancher, some argocd)
# ----------------------------------------------------------------------

variable "monitoring_enabled" {
  type        = bool
  description = "Enable monitoring in rancher"
  default     = true
}

variable "cinder_enabled" {
  type        = bool
  description = "Enable cinder storage"
  default     = false
}

variable "longhorn_enabled" {
  type        = bool
  description = "Enable longhorn storage"
  default     = true
}

variable "longhorn_replicas" {
  type        = string
  description = "Number of replicas"
  default     = 3
}

variable "nfs_enabled" {
  type        = bool
  description = "Enable NFS storage"
  default     = true
}

variable "healthmonitor_enabled" {
  type        = bool
  description = "Enable healthmonitor"
  default     = true
}

variable "healthmonitor_nfs" {
  type        = bool
  description = "Enable healthmonitor nfs"
  default     = true
}

variable "healthmonitor_secrets" {
  type        = string
  description = "Secrets (config/checks/notifications) for healthmonitor"
  default     = "config"
}

variable "sealedsecrets_enabled" {
  type        = bool
  description = "Enable sealed secrets"
  default     = false
}

variable "metallb_enabled" {
  type        = bool
  description = "Enable MetalLB"
  default     = true
}

# ----------------------------------------------------------------------
# INGRESS
# working:
# - traefik1
# - traefik2
# - none
# work in progress
# - nginx
# - nginxinc
# ----------------------------------------------------------------------

variable "ingress_controller_enabled" {
  type        = bool
  description = "Enable IngressController"
  default     = true
}

variable "ingress_controller" {
  type        = string
  description = "Desired ingress controller (traefik1, traefik2, nginxinc, nginx, none)"
  default     = "traefik2"
}

variable "ingress_storageclass" {
  type        = string
  description = "storageclass used by ingress controller"
  default     = "nfs-taiga"
}

# ----------------------------------------------------------------------
# TRAEFIK
# ----------------------------------------------------------------------

variable "traefik_dashboard" {
  type        = bool
  description = "Should dashboard ingress rule be added as /traefik"
  default     = true
}

variable "traefik_server" {
  type        = string
  description = "Desired hostname to be used for cluster, nip.io will use ip address"
  default     = ""
}

variable "traefik_access_log" {
  type        = bool
  description = "Should traefik enable access logs"
  default     = false
}

variable "traefik_use_certmanager" {
  type        = bool
  description = "Should traefik v2 use cert manager"
  default     = false
}

variable "traefik2_ports" {
  type        = map(any)
  description = "Additional ports to add to traefik"
  default     = {}
}

# ----------------------------------------------------------------------
# LETS ENCRYPT
# ----------------------------------------------------------------------

variable "acme_staging" {
  type        = bool
  description = "Use the staging server"
  default     = false
}

variable "acme_email" {
  type        = string
  description = "Use the following email for cert messages"
  default     = "devops.isda@lists.illinois.edu"
}
