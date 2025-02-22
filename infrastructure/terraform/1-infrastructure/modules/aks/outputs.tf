output "debug_secret_values" {
  sensitive = true
  value = {
    username_received = var.github_username != "" ? "yes" : "no"
    pat_received     = var.github_pat != "" ? "yes" : "no"
    username_length  = length(var.github_username)
    pat_length      = length(var.github_pat)
  }
}