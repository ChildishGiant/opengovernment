class DistrictsController < ApplicationController
  before_filter :find_district, :except => :search

  def search
    @point = GeoKit::Geocoders::MultiGeocoder.geocode(params[:q])

    if @point
      @state = State.find_by_abbrev(@point.state)
      redirect_to state_path(@state) unless @state.nil? || @state.supported?
    end

  end

  def find_district
    @district = params[:id] ? District.find_by_id(params[:id]) : nil
  end
end
