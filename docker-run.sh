#!/bin/sh

open http://localhost:3000/api/hello

docker run -it --name weesvc-rails --rm -p 3000:3000 \
 github.com/weesvc/weesvc-rails:0.0.1-SNAPSHOT \
 /bin/sh -c "rails db:setup; rails db:migrate; rails server -b 0.0.0.0"
