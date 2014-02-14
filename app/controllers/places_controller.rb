class PlacesController < ApplicationController

    def index
    end

    def show
        @pub = BeermappingApi.pubs_in(session[:city], params[:id]) unless session[:city].nil?
        
    end

    def search
        @places = BeermappingApi.places_in(params[:city])

        if @places.empty?
            session[:city] = nil
            redirect_to places_path, :notice => "No places in #{params[:city]}"
        else
            session[:city] = params[:city]
            render :index
        end
    end
end