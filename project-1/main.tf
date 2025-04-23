module "network" {
  source = "./network/"  # <- update this to your new folder
  # other variables...
}

module "application" {
  source = "./application/"  # <- update this to your new folder
  # other variables...
}
