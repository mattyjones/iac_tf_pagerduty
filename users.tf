# Pagerduty Users
resource "pagerduty_user" "User_Four" {
  name  = "User Four"
  email = "user.four@gmail.com"
  role  = "limited_user"
  teams = ["${pagerduty_team.Team_Two.id}", "${pagerduty_team.Team_One.id}"]
}

resource "pagerduty_user" "User_Three" {
  name  = "User Three"
  email = "user.three@gmail.com"
  role  = "limited_user"
  teams = ["${pagerduty_team.Team_One.id}","${pagerduty_team.Team_Three.id}"]
}

resource "pagerduty_user" "User_Two" {
  name  = "User Two"
  email = "user.two@gmail.com"
  role  = "limited_user"
  teams = ["${pagerduty_team.Team_Two.id}","${pagerduty_team.Team_Three.id}"]
}
resource "pagerduty_user" "User_One" {
  name  = "User One"
  email = "user.one@gmail.com"
  role  = "limited_user"
  teams = ["${pagerduty_team.Team_Two.id}"]
}
