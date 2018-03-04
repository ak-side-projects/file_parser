## File Parser

### DB Setup
Setup a postgres database for your environments via your favorite method
(maybe https://www.codementor.io/engineerapart/getting-started-with-postgresql-on-mac-osx-are8jcopb).
Modify `config/database.yml` accordingly.
Then install Ruby PG via `gem install pg`.

### Execution
`$ cd` into project folder. Dump files in the `\data` and `\specs` folders.
Then run `$ ruby main.rb`. Project comes preloaded with 3 data
files and 2 spec files. Feel free to remove them and use your own.

### Querying via IRB
You can use `$ irb` to open an interactive ruby console. To query your imported
data, you can use the `PgQueryService` class. Make sure the file is loaded:
`load #{filepath}`. Then you can run `PgQueryService.records_from_table(table_name)` where `table_name` is the "file type" of one of the imported data files.

### Tests
Tests are written in Rspec (`gem install rspec`) and can be run via
`$ rspec spec` from the root project directory.
