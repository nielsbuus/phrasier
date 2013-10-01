# Phrasier

Phrasier is an unofficial Ruby library that wraps the PhraseApp Rest API. Ultimately it should support all operations, but currently it only supports (batch) deletion of keys and display of tags. The goal of this library to develop a gem that makes batch manipulation of keys across languages and projects easier. Phrasier has not been published to Rubygems yet, as it is incomplete.

Phrasier is currently tailored for usage through IRB.

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
