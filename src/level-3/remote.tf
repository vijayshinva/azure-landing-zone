# Get the connectivity and management configuration
# settings from outputs via the respective terraform
# remote state files

data "terraform_remote_state" "level-1" {
  backend = "azurerm"

  config = {
    container_name       = "tfstate-level-1"
    key                  = "prod.level-1.tfstate"
    access_key           = "${var.TFSTATE_STORAGE_ACCOUNT_KEY}"
    storage_account_name = "${var.TFSTATE_STORAGE_ACCOUNT_NAME}"
  }
}

data "terraform_remote_state" "level-2" {
  backend = "azurerm"

  config = {
    container_name       = "tfstate-level-2"
    key                  = "prod.level-2.tfstate"
    access_key           = "${var.TFSTATE_STORAGE_ACCOUNT_KEY}"
    storage_account_name = "${var.TFSTATE_STORAGE_ACCOUNT_NAME}"
  }
}
