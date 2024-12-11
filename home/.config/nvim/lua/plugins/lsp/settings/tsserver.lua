return {
  on_attach = function(server)
    server.server_capabilities.documentFormattingProvider = false
  end
}
