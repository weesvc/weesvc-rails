# WeeSVC Rails
Implementation of the WeeSVC application using [Ruby](https://www.ruby-lang.org/) and [Rails]](https://rubyonrails.org/).

## Ingredients
The following external libraries were *directly* utilized in this project.

| Package     | Link                                   | Description                                                             |
| ---         | ---                                    | ---                                                                     |
| Ruby        | https://www.ruby-lang.org/             | Well...it's obvious isn't it?!                                          |
| Rails       | https://rubyonrails.org/               | Framework for modern web applications                                   |
| SQLite      | https://www.sqlite.org/index.html      | The lightweight database                                                |

## Build
TODO

#### CLI
TODO 

#### Docker
TODO

## Using the Application
TODO
```
rails new weesvc-rails-api --api
rails generate model Place name:string description:string 
rails generate controller api/places
rails db:setup
rails db:migrate
rails server
```
Thanks to https://medium.com/@oliver.seq/creating-a-rest-api-with-rails-2a07f548e5dc




## API Compliance
A core requirement for all _WeeSVC_ implementations is to implement the same API which are utilized for benchmark comparisons. To ensure compliance with the required API, [k6](https://k6.io/) is utilized within the [Workbench](https://github.com/weesvc/workbench) project.

To be a valid service, the following command MUST pass at 100%:
```
k6 run -e PORT=3000 https://raw.githubusercontent.com/weesvc/workbench/main/scripts/api-compliance.js
```
