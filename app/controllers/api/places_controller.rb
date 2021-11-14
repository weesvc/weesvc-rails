class Api::PlacesController < ApplicationController
    before_action :find_place, only: [:show, :update, :destroy]

    # GET /places
    def index 
        @places = Place.all
        render json: @places
    end

    # GET /places/:id
    def show 
        render json: @place
    end

    # POST /places
    def create 
        @place = Place.new(place_params)
        if @place.save 
            render json: @place
        else
            render error: { error: 'Unable to create Place.' }, status: 400
        end
    end

    # PUT /places/:id
    def update 
        if @place
            @place.update(place_params)
            render json: @place
        else
            render error: { error: 'Unable to update Place.' }, status: 400
        end
    end

    # DELETE /places/:id
    def destroy 
        if @place
            @place.destroy
            render json: { message: 'Place successfully deleted.' }, status: 200
        else
            render error: { error: 'Unable to delete Place.' }, status: 400
        end
    end

    private

    def place_params
        params.require(:place).permit(:name, :description, :latitude, :longitude)
    end    

    def find_place
        @place = Place.find(params[:id])
    end

end
