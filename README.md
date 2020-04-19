# rails-portfolio-project

A digital learning management system. Teachers can create courses, lessons, and tags to categorize them with. Students can sign in to access those learning resources.

License:
https://github.com/boom100100/rails-portfolio-project/blob/master/LICENSE

Install:

Fork, then clone the repo:
```
git clone https://github.com/your-username/rails-portfolio-project.git
```

Install gems (see Gemfile for version of rails):

```
bundle install
```

Set up database:
```
rake db:migrate
```
Seed database:
```
rake db:seed
```

Use seeds or
```
rails c
```
to create admin account. Be sure to omit or remove seed admin accounts from production environment.

Declare Active Storage services in config/storage.yml. Tell Active Storage which service to use by setting Rails.application.config.active_storage.service in environments. See https://edgeguides.rubyonrails.org/active_storage_overview.html for further guidance for Active Storage setup.
