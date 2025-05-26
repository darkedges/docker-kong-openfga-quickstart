resource "openfga_store" "api" {
  name = "providerapi"
}

data "openfga_authorization_model_document" "api" {
  dsl = <<EOT
model
  schema 1.1

type user

type document
  relations
    define viewer: [user]
  EOT
}

resource "openfga_authorization_model" "api" {
  store_id   = openfga_store.api.id
  model_json = data.openfga_authorization_model_document.api.result
}

resource "openfga_relationship_tuple" "api" {
  store_id               = openfga_authorization_model.api.store_id
  authorization_model_id = openfga_authorization_model.api.id
  user                   = "user:user-1"
  relation               = "viewer"
  object                 = "document:document-1"
}
