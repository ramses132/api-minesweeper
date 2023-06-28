require_relative '../../../lib/context_di'

# Api Module Routing
module Api
  # v1 Module Routing
  module V1
    # Player controller Class
    class PlayersController < ApplicationController
      def initialize
        super
        @player_service = Container['player_service']
      end

      def initialize_services
        @game_service = Container['player_service']
      end

      def find_or_create
        player, is_created = @player_service.find_or_create(params[:name])

        render json: { id: player.id, name: player.name, is_created:, score: player.score, games: player.games },
               status: :ok
      end

      def show
        player = @player_service.find_by_id(params[:id])
        if player.nil?
          render json: { error: "Player #{params[:id]} not found" }, status: :not_found
        else
          render json: { id: player.id, name: player.name, score: player.score, games: player.games }, status: :ok
        end
      end

      def hello
        render json: { message: 'Hola Mundo!' }
      end
    end
  end
end
