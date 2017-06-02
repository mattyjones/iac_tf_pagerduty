## SETUP

1. `brew install terraform`
2. create a pagerduty api [token][1] within pagerduty and set your name in the description
3. set the api token via environment variable **TF_VAR_pagerduty_token** (DO NOT hardcode it in the repo)

## Usage

### Adding a user

 **All changes should be made in `users.tf` following best practices**

 ```
 resource "pagerduty_user" "User_Four" {
  name  = "User Four"
  email = "user.four@gmail.com"
  role  = "limited_user"
  teams = ["${pagerduty_team.Team_Two.id}", "${pagerduty_team.Team_One.id}"]
}
```

Copy the above snippet into the users file, changing the values as needed. The user name `User Four` and the resource name `User_Four` must match. The role should be set to `limited_user` unless manager approval is given. The team **must** follow the given format to ensure that the teams a user is assigned to are created first. Teams can be found in `teams.tf`

By using the `id` that is outputed from the *pagerduty_team* resource, terraform will ensure that the team is created before the user. If you are creating a new user than an invitation will automatically be sent to the email address with details about the account.

### Adding a team

 **All changes should be made in `teams.tf` following best practices**

 ```
 resource "pagerduty_team" "Team_Two" {
  name        = "Team Two"
}
```

Copy the above snippet into the teams file, changing the values as needed. The team name `Team Two` and the resource name `Team_Two` must match. The name **must** follow the given format to ensure that the teams a user is assigned to are created first. Users can be found in `userss.tf`


## Best Practices

- All entries should be in alphabetical order by the *name* field
- You should not reference by `count.index` across multiple resources as consistency cannot be guaranteed, use `self.foo` where possible

[1]: https://support.pagerduty.com/hc/en-us/articles/202829310-Generating-an-API-Key
