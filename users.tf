variable "users" {
  type = "list"

  default = [
    {
      name  = "User One"
      email = "user.one@gmail.com"
      teams = ["Team One"]
      role  = "limited_user"
    },
    {
      name  = "User Two"
      email = "user.two@gmail.com"
      teams = ["Team Two"]
      role  = "admin"
    },
    # {
    #   name  = "User Four"
    #   email = "user.four@gmail.com"
    #   teams = ["Team Two"]
    #   role  = "limited_user"
    # },
  ]

  # {
  #   name  = "User Three"
  #   email = "user.three@gmail.com"
  #   teams = ["Team One", "Team Two"]
  #   role  = "limited_user"
  # },
}
