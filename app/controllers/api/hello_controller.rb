class Api::HelloController < ApplicationController

    def index
      render :json => {
        :hello => "world",
        :remote_address => request.remote_ip
      }
    end

end
