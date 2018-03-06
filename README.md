## File Parser

### About
This project is intentionally lightweight and doesn't leverage a heavy
framework. There are pros and cons to this, just as there are for the data
storage decisions. One of the benefits of keeping it lightweight is that it
can easily be modified if the requirements (or baseline assumptions) change.

### Setup
#### ruby
Ensure you have ruby installed (`$ ruby --version`).
If not, visit https://www.ruby-lang.org/en/documentation/installation/ and
follow the instructions.

#### postgresql
Setup a postgres database for your environments via your favorite method
(maybe https://www.codementor.io/engineerapart/getting-started-with-postgresql-on-mac-osx-are8jcopb).
Modify `config/database.yml` accordingly.
Then install Ruby PG via `gem install pg`.

### Execution
`$ cd` into project folder. Dump files in the `\data` and `\specs` folders.
Then run `$ ruby main.rb`. Project comes preloaded with 3 data
files and 2 spec files. Feel free to remove them and use your own.

### Querying
#### irb
You can use `$ irb` to open an interactive ruby console. To query your imported
data, you can use the `PgQueryService` class. Make sure the file is loaded:
`load #{filepath}`. Then you can run `PgQueryService.records_from_table(table_name)`
where `table_name` is the "file type" of one of the imported data files.

#### psql
Use `$psql ${db_url_or_db_name}` where `${db_url_or_db_name}` is the
interpolated DB URL or local DB Name. This will open up a psql console to
the DB and you can query the DB using raw SQL.

### Tests
Tests are written in Rspec (`gem install rspec`) and can be run via
`$ rspec spec` from the root project directory.
