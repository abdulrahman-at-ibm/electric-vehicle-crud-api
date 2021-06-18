module Api
  module V1
    class VehiclesController < ApplicationController
      def index
        vehicles = Vehicle.where(nil) # anonymous scope
        vehicles = vehicles.filter_by_make(params[:make]) if params[:make].present?
        vehicles = vehicles.filter_by_model(params[:model]) if params[:model].present?
        vehicles = vehicles.filter_by_year(params[:year]) if params[:year].present?
        render json: vehicles
      end

      def show
        vehicle = Vehicle.find(params[:id])

        render json: vehicle, status: :ok
      end

      def create
        vehicle = Vehicle.new(vehicle_params)

        if vehicle.save
          render json: vehicle, status: :created
        else
          render json: vehicle.errors, status: :unprocessable_entity
        end
      end

      def update
        vehicle = Vehicle.find(params[:id])
    
        if vehicle.update(vehicle_params)
          render json: vehicle, status: :ok
        else
          render json: vehicle.errors, status: :unprocessable_entity
        end
      end    

      def destroy
        vehicle = Vehicle.find(params[:id])

        vehicle.destroy!

        head :no_content
      end

      private

      def vehicle_params
        params.require(:vehicle).permit(:make, :model, :year)
      end
    end
  end
end
