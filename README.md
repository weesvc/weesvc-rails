# WeeSVC Rails
Implementation of the WeeSVC application using [Ruby](https://www.ruby-lang.org/) and [Rails]](https://rubyonrails.org/).

## Ingredients
The following external libraries were *directly* utilized in this project.

| Package     | Link                                   | Description                                                             |
| ---         | ---                                    | ---                                                                     |
| Ruby        | https://www.ruby-lang.org/             | Well...it's obvious isn't it?!                                          |
| Rails       | https://rubyonrails.org/               | Framework for modern web applications                                   |
| Puma        | https://puma.io/                       | Web server for executing your Rails application                         |
| SQLite      | https://www.sqlite.org/index.html      | The lightweight database                                                |

## Build
Builds are performed using the `Rakefile` provided in the project root.

#### CLI
In order to buid from the command-line, you'll need to have Ruby (3.0+) and Rails (6.1.4+) installed on your system.

:point_up: NOTE: To initially build the project, you may need to run the `rake` command to install the tools utilized for builds.

Once built, you can **migrate** the database scripts and run the application:
```shell script
$ rails db:setup; rails db:migrate; rails server
```

#### Docker
For those who do not have the Ruby and Rails dependencies installed locally, [Docker](https://hub.docker.com/) is an option to build the application and run the application within a container.

To execute the Rails application, use the following Docker command to create your image:
```shell script
docker build -t github.com/weesvc/weesvc-rails:0.0.1-SNAPSHOT .
```
Once the the image is available, you can simply run the provided script which will open a browser to access the service
at http://localhost:3000/api/hello .

```shell script
$ ./docker-run.sh
```
:point_up: NOTE: the `docker-run.sh` script is setup to **not** maintain state between executions.  This means each
time you start the container, you will be starting with a freshly created database.

## Using the Application
:point_up: TIP: Use the very cool [HTTPie](https://httpie.org/) application for testing locally from the command-line.  

Execute a `GET` command to retrieve the available _places_ from the database.
```shell script
$ http GET :3000/api/places

HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

[]
```
Add a _place_ into the database using a `POST` command.
```shell script
$ http POST :3000/api/places name=NISC description="NISC Lake St. Louis Office" latitude:=38.7839 longitude:=90.7878

HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
    "created_at": "2021-11-14T19:07:38.049Z",
    "description": "NISC Lake St. Louis Office",
    "id": 1,
    "latitude": 38.7839,
    "longitude": 90.7878,
    "name": "NISC",
    "updated_at": "2021-11-14T19:07:38.049Z"
}
```
Run the `GET` command again to retrieve _places_ which now include your newly added _place_!
```shell script
$ http GET :3000/api/places

HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

[
    {
        "created_at": "2021-11-14T19:10:32.042Z",
        "description": "NISC Lake St. Louis Office",
        "id": 1,
        "latitude": 38.7839,
        "longitude": 90.7878,
        "name": "NISC",
        "updated_at": "2021-11-14T19:10:32.042Z"
    }
]
```
Use the `PATCH` command to update a specific value.  For example we'll update the `Description` as follows:
```shell script
$ http PATCH :3000/api/places/1 description="Lake St. Louis"

HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
    "created_at": "2021-11-14T19:10:32.042Z",
    "description": "Lake St. Louis",
    "id": 1,
    "latitude": 38.7839,
    "longitude": 90.7878,
    "name": "NISC",
    "updated_at": "2021-11-14T19:13:16.232Z"
}
```
This returns the newly "patched" version of the _place_.  Next we'll remove the row using the `DELETE` method.
```shell script
$ http DELETE :3000/api/places/1

HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
    "message": "Place successfully deleted."
}
```

## API Compliance
A core requirement for all _WeeSVC_ implementations is to implement the same API which are utilized for benchmark comparisons. To ensure compliance with the required API, [k6](https://k6.io/) is utilized within the [Workbench](https://github.com/weesvc/workbench) project.

To be a valid service, the following command MUST pass at 100%:
```
k6 run -e PORT=3000 https://raw.githubusercontent.com/weesvc/workbench/main/scripts/api-compliance.js
```
