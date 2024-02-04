variable "app_name" {
  type        = string
  description = "Application Name"
  default     = "mage-data-prep"
}

variable "credentials" {
  description = "My Credentials"
  default     = "../de-zoomcamp-412517-9afc71142b9d.json"
  #ex: if you have a directory where this file is called keys with your service account json file
  #saved there as my-creds.json you could use default = "./keys/my-creds.json"
}

variable "container_cpu" {
  description = "Container cpu"
  default     = "2000m"
}

variable "container_memory" {
  description = "Container memory"
  default     = "2G"
}

variable "project_id" {
  type        = string
  description = "The name of the project"
  default     = "de-zoomcamp-412517"
}

variable "region" {
  type        = string
  description = "The default compute region"
  default     = "us-west2"
}

variable "zone" {
  type        = string
  description = "The default compute zone"
  default     = "us-west2-a"
}

variable "location" {
  type        = string
  description = "The default compute zone"
  default     = "US"
}

variable "repository" {
  type        = string
  description = "The name of the Artifact Registry repository to be created"
  default     = "mage-data-prep"
}

variable "database_user" {
  type        = string
  description = "The username of the Postgres database."
  default     = "mageuser"
}

variable "database_password" {
  type        = string
  description = "The password of the Postgres database."
  sensitive   = true
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  #Update the below to a unique bucket name
  default     = "terraform-demo-de-zoomcamp"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}

variable "docker_image" {
  type        = string
  description = "The docker image to deploy to Cloud Run."
  default     = "mageai/mageai:latest"
}

variable "domain" {
  description = "Domain name to run the load balancer on. Used if `ssl` is `true`."
  type        = string
  default     = ""
}

variable "ssl" {
  description = "Run load balancer on HTTPS and provision managed certificate with provided `domain`."
  type        = bool
  default     = false
}
