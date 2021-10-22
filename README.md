# Filbunke

A WIP file host site.

## Development
Use one of the methods below to set up and start a development environment.

Once started, the Rails site will be available at http://localhost:3000.

### Docker
For quick development, a docker compose file is provided, along with a helper
script to start the necessary services:

    bin/dockerdev

The helper script will append any passed arguments to the `docker compose`
command. This means you can start the services in detached mode by simply
adding the `-d` switch:

    bin/dockerdev -d

This assumes you have [Compose V2][docker-compose-v2] available.

### Traditional
For more traditional development, you'll need the following installed:

 * Ruby (exact version can be found in the `.ruby-version` file)
 * Node.js
 * Yarn
 * PostgreSQL (v12)

Then set up the project:

```
bundle install
yarn install
bundle exec rails db:prepare
```

If you have Hivemind, you can use the supplied `Procfile` to run the Rails
server together with the webpack dev server:

    hivemind

**Note:** You have to add a `.env` file that sets `PORT=3000`,
otherwise Hivemind starts the Rails server on port 5000.

If you don't have Hivemind available you can start the servers manually:

    bundle exec rails server
    bin/webpack-dev-server

## License

Copyright &copy; 2021 by [Adam Hellberg][sharparam].

This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.

[sharparam]: https://sharparam.com
[docker-compose-v2]: https://docs.docker.com/compose/cli-command/
