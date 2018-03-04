## File Parser

### DB Setup
Setup a postgres database for your environments via your favorite method (maybe https://www.codementor.io/engineerapart/getting-started-with-postgresql-on-mac-osx-are8jcopb).
Modify `config/database.yml` accordingly.
Then install Ruby PG via `gem install pg`.

### Execution
`$ cd` into project folder. Define files in the `\data` and `\specs` folders.
Then run `$ ruby file_import_manager.rb`. Project comes preloaded with 3 data
files and 2 spec files. Feel free to remove them and use your own.

### Tests
Tests are written in Rspec (`gem install rspec`) and can be run via `$ rspec spec`.
