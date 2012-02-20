Deprecated as of Rails 3.2
==========================

This library is, happily, no longer useful now that Rails 3.2 has introduced the `without_protection: true` option!

So instead of 

    user = User.unprotected_new(
      name: 'Some Name',
      email: 'test@example.com',
      ...
      is_admin: true,
      state: :active
    )

you can now do this in Rails 3.2+:

    user = User.new({
      name: 'Some Name',
      email: 'test@example.com',
      ...
      is_admin: true,
      state: :active
    }, without_protection: true)

Please use that built-in feature instead. This library will no longer be maintained.

Let me mass-assign protected attributes!
========================================

Normally when you try to do a mass-assignment (or a `new`/`create`) and you include in your attributes hash an attribute that is protected (by an `attr_accessible` or `attr_protected` somewhere in your model), Active Record will complain with a warning such as this in your log file:

     WARNING: Can't mass-assign protected attributes: is_admin, state

But what if you really *want* to mass-assign those protected attributes anyway and you have a legitimate reason for doing so?

For example, sometimes you need to create a record in your tests with certain pre-determined values for all of its attributes, *including* the protected ones.

You *could* always do a regular (non-mass) attribute assignment for each of your protected attributes after your main mass-assignment/`new`/`create`...

    user = User.new(
      name: 'Some Name',
      email: 'test@example.com',
      ...
    ) do |user|
      user.is_admin = true
      user.state = :active
    end

But now there's an easier way!

    user = User.unprotected_new(
      name: 'Some Name',
      email: 'test@example.com',
      ...
      is_admin: true,
      state: :active
    )

In addition to `unprotected_new`, this gem provides these instance methods to `ActiveRecord::Base`:

* `unprotected_attributes=`
* `unprotected_update_attributes`/`unprotected_update_attributes!`

and these class methods:

* `unprotected_new`
* `unprotected_create`/`unprotected_create!`

Thank you, Active Record, for always protecting me from doing stupid things. But sometimes I *want* to have unprotected mass-assigns, so stop protecting me for just a second while I intentionally change some protected attributes...

More examples:

    user = User.unprotected_create!(
      name: 'Some Name',
      email: 'test@example.com',
      ...
      is_admin: true,
      state: :active
    )

    if user.unprotected_update_attributes(name: 'New name', is_admin: false)
      ...
    end

It also appears to work with associations:

    user.memberships.unprotected_create!(state: 'active')

Installation
============

Add to your Gemfile:

    group :test do
      gem 'let_me_mass_assign_protected_attributes'
    end

Further reading
===============

* http://api.rubyonrails.org/classes/ActiveRecord/Base.html (for information about `attr_accessible`/`attr_protected`)
* http://railscasts.com/episodes/26-hackers-love-mass-assignment (for why you *should* be using `attr_accessible`/`attr_protected`)

To do
=====

* invitation.unprotected_build_membership(role: 'leader')
* Allow passing a block like you can with normal new/create
* Add tests

Contributing
============

Comments and contributions are welcome.

Please feel free to fork the project at https://github.com/TylerRick/let_me_mass_assign_protected_attributes and to send pull requests.

Bugs can be reported at https://github.com/TylerRick/let_me_mass_assign_protected_attributes/issues

License
=======

Copyright 2011, Tyler Rick

This is free software, distributed under the terms of the MIT License.
