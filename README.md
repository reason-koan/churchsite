# Churchsite

![Build status](https://travis-ci.org/binary-koan/churchsite.svg?branch=master)

Rails setup intended for the [Lincoln Union Church website](http://lincolnchurch.org.nz) but which
could be made to work for other churches or organisations.

## Requirements

In addition to the [standard requirements for Ruby on Rails](http://guides.rubyonrails.org/getting_started.html#installing-rails)
you will need

- [MongoDB](https://www.mongodb.org/)
- [ImageMagick](http://www.imagemagick.org/script/index.php) or GraphicsMagick

Since this is intended to be deployed to OpenShift, you may also want to install the `rhc` gem.

## Setup

As with any Rails site, you can start a local development server with `bundle exec rails server`,
but you'll need to manually create an admin user before you can actually do anything. The easiest
way to do that is to seed the database:

```
INITIAL_USER_NAME="Your name" INITIAL_USER_EMAIL="you@domain.com" INITIAL_USER_PASSWORD="secret" bundle exec rails db:seed
```

This also creates a default homepage, but to make things work you'll need to go to `/admin`, log in
with the credentials you decided on above, and create and edit pages and settings.
