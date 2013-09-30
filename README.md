# Phrasier

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'phrasier'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install phrasier

## Usage

Before you can use Phrasier, you must create a configuration file called credentials.json within your working directory that contains your e-mail and password for Phrase along with project auth tokens for the projects you want to manipulate.

Here is an example:

    {
      "email": "foo@bar.net",
      "password": "foobarbaz",
      "projects": [
        {
          "name": "primary project",
          "project_auth_token": "d599f6c20042fe5d70fb0107daa2a2de"
        },
        {
          "name": "something else",
          "project_auth_token": "ac6224f3d9047e98aee28e3e607ce9df"
        }
      ]
    }
