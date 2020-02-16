# Rails Blog App

記事の CRUD アプリケーション

## System dependencies

- MySQL 5.7
- Redis 5.0.7
- ElasticSearch 7.6.0
- Logstash 7.6.0

## Setup

- Homebrew

```
# MySQL
$ brew install mysql@5.7
$ brew services start mysql@5.7

# Redis
$ brew install redis
$ brew services start redis

# ElasticSearch
$ brew tap elastic/tap
$ brew install elastic/tap/elasticsearch-full
$ elasticsearch

# Rails
$ bundle install --path vendor/bundle
$ bin/rails s
```

## How to run the test suite

`$ bundle exec rspec`
