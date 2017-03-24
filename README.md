# Code Climate Proselint Engine

[![Code Climate][badge]][repo]

[badge]: https://codeclimate.com/github/dblandin/codeclimate-proselint/badges/gpa.svg
[repo]: https://codeclimate.com/github/dblandin/codeclimate-proselint

A Code Climate engine for [Proselint][]: a linter for prose.

> Proselint places the world’s greatest writers and editors by your side, where
> they whisper suggestions on how to improve your prose.

You can run this engine on the command line, using the [Code Climate CLI][cli],
or on Code Climate's [hosted analysis platform](https://codeclimate.com).

### Installation

1. If you haven't already, [install the Code Climate CLI][CLI]

1. Run `codeclimate engines:enable proselint`. This command both installs the
   engine and enables it in your `.codeclimate.yml` file

1. You're ready to analyze! Browse into your project's folder and run
   `codeclimate analyze`

[cli]: https://github.com/codeclimate/codeclimate

### Need help?

For an issue specific to Proselint, check out the [project on GitHub][proselint-gh].

For engine issues, open an issue [here][issues].

[issues]: https://github.com/dblandin/codeclimate-proselint/issues
[proselint]: http://proselint.com/
[proselint-gh]: https://github.com/amperser/proselint
