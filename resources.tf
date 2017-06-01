# Create users
resource "pagerduty_user" "user" {
  count = "${length("${var.users}")}"

  name  = "${lookup(var.users[count.index], "name")}"
  email = "${lookup(var.users[count.index], "email")}"
  role  = "${lookup(var.users[count.index], "role")}"

  #   teams = "${lookup(var.users[count.index], "teams")}"
}

# Create teams
resource "pagerduty_team" "team" {
  count = "${length("${var.teams}")}"

  name = "${lookup(var.teams[count.index], "name")}"
}
