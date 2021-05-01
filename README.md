# Easy Lambda Deploy

This action will help with updating a lambda function code easily.

⚠️ Please note that the function will not be created, it must exist already.

## How does this work ?
This action does two things:

1/ Adds files into a zip file:

This action will create a zip file from your code.
It will use the default command `zip -r` to create the zip bundle. It will be named `easy-lambda-deploy.zip`

2/ Deploys the lambda code

The action will use aws-cli to deploy code to lambda. This means that you MUST provide AWS credentials as environment variables
in order to deploy your code. You can use [Repository Secrets](https://docs.github.com/en/actions/reference/encrypted-secrets) to store and use them
securely with GitHub.

## Usage Example

```yml
name: Update lambda

on:
  release:
    types: ["published"]

jobs:
  update_lambda:
    name: 'Pull code & update lambda'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2

      - uses: jsmrcaga/action-easy-lambda-deploy@latest
        name: Update lambda code
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        with:
          function_name: crypto_bot
          region: eu-west-3
```

## Inputs

| Name | Required | Default | Description |
|:----:|:--------:|:-------:|:-----------:|
| `function_name` | Yes |  | The unique name of your lambda function |
| `region` | Yes |  | The region where your lambda function resides |
| `zip_files` | No | `*` (all files in cwd) | List of specific files and folders to add into zip file before deploying. Ex: `index.js lib.js node_modules` |
| `zip_command` | No |  | Custom `zip` command. Overrides `zip_files` |
