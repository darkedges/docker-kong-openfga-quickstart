resource "kong_service" "service" {
  name            = "api"
  protocol        = "http"
  host            = "api.localdev"
  port            = 8080
  path            = "/"
  retries         = 5
  connect_timeout = 1000
  write_timeout   = 2000
  read_timeout    = 3000
}

resource "kong_route" "route" {
  name           = "provider"
  protocols      = ["http"]
  methods        = ["GET"]
  paths          = ["/provider"]
  strip_path     = true
  preserve_host  = false
  regex_priority = 0
  service_id     = kong_service.service.id
}

resource "kong_plugin" "openfga" {
  name     = "kong-authz-openfga"
  route_id = kong_route.route.id
  config_json = jsonencode(
    {
      "host" : "openfga",
      "port" : 8080,
      "store_id" : "${openfga_store.api.id}",
      "tuple" : {
        "user" : "user:user-1",
        "relation" : "viewer",
        "object" : "document:document-1"
      }
    }
  )
}
