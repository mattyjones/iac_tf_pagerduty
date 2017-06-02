## SETUP

1. `brew install terraform`
2. create a pagerduty api [token][1] within pagerduty and set your name in the description
3. set the api token via environment variable **TF_VAR_pagerduty_token** (DO NOT hardcode it in the repo)

## Usage

### Adding a user

 **All changes should be made in `users.tf` following best practices**

 ```json
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

 ```json
 resource "pagerduty_team" "Team_Two" {
  name        = "Team Two"
}
```

Copy the above snippet into the teams file, changing the values as needed. The team name `Team Two` and the resource name `Team_Two` must match. The name **must** follow the given format to ensure that the teams a user is assigned to are created first. Users can be found in `userss.tf`


## Best Practices

- All entries should be in alphabetical order by the *name* field
- You should not reference by `count.index` across multiple resources as consistency cannot be guaranteed, use `self.foo` where possible

[1]: https://support.pagerduty.com/hc/en-us/articles/202829310-Generating-an-API-Key

## Troubleshooting

### If a managed team/user has been deleted using the UI

If an entity has been deleted via the ui, when you run terraform plan next you will get a 404 as the endpoint for that entity does not exist. 

`* pagerduty_user.User_One: pagerduty_user.User_One: Failed call API endpoint. HTTP response code: 404. Error: &{2100 Not Found <nil>}`

In order to fix this **DO NOT** add the entity back into the ui. While this may work, there could be unforseen consequences. The proper way to fix an entity deletion issue is so edit the statefile and remove that entity from it. In the following snippet we have a user state, you would search for the user, email is the easiest way most likely, and remove their definition. Currently using `terraform taint` is not support by the pagerduty provider but it would be the correct way to perform this action going forward.

```json
"pagerduty_user.User_One": {
                    "type": "pagerduty_user",
                    "depends_on": [
                        "pagerduty_team.Team_Two"
                    ],
                    "primary": {
                        "id": "PZ7VH1A",
                        "attributes": {
                            "avatar_url": "https://secure.gravatar.com/avatar/12bb8d6fee33b19874110c2e9ca5d58c.png?d=mm\u0026r=PG",
                            "color": "green",
                            "description": "Managed by Terraform",
                            "email": "user.one@gmail.com",
                            "id": "PZ7VH1A",
                            "job_title": "",
                            "name": "User One",
                            "role": "limited_user",
                            "teams.#": "1",
                            "teams.4179140303": "PJFKBAG",
                            "time_zone": ""
                        },
                        "meta": {},
                        "tainted": false
                    },
                    "deposed": [],
                    "provider": ""
                },
```

## If a managed user has been modified using the UI

If a user has had privileges or other attributes changed via the ui, just rerun terraform and it will correct the issue and bring that user back to the state defined in the resource. 
