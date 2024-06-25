terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.27.0"
    }
  }
}

provider "google" {
  credentials = "labKey.json"
  project     = "terraf-392514"
  region      = "us-central1"
}

resource "google_cloud_run_v2_service" "run-app-from-tf"{
  
    name = "run-app-from-tf"
    location = "us-central1"
    ingress = "INGRESS_TRAFFIC_ALL"
    
   
    
  template {
    containers {
    #   image = "us-docker.pkg.dev/cloudrun/container/hello"
        image = "gcr.io/terraf-392514/hello"
    #     ports {
    #         container_port = 8080
    #    }
  }

    # traffic {
    #     percent = 50
    #     revision = ""
    # }

    # traffic {
    #     percent = 50
    #     revision = ""
    # }
}
}

data "google_iam_policy" "pub1" {
  binding {
    role = "roles/run.invoker"
    members = ["allUsers"]
  }
}
resource "google_cloud_run_v2_service_iam_policy" "policy" {
    
    name = google_cloud_run_v2_service.run-app-from-tf.name
    location = google_cloud_run_v2_service.run-app-from-tf.location
    # project = google_cloud_run_v2_service.google.project
    # members = ["allUsers"]
    # role = "roles/run.invoker"
    policy_data = data.google_iam_policy.pub1.policy_data

}