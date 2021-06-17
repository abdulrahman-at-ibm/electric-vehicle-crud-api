module Api
  module V1
    class VehiclesController < ApplicationController
      def index
        render json: Vehicle.all
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
