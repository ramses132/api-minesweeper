# frozen_string_literal: false

require_relative '../../../lib/context_di'
require 'errors/invalid_argument_error'
require 'renderers/game_renderer'
require 'validators/action_params_validator'
require 'validators/game_params_validator'

# Api Module Routing
module Api
  # v1 Module Routing
  module V1
    # Game controller Class
    class GamesController < ApplicationController
      rescue_from Errors::InvalidArgumentError, with: :handle_invalid_argument_error

      def initialize
        super
        @game_service = Container['game_service']
      end

      def initialize_services
        @game_service = Container['game_service']
      end

      def create
        game_params_validator = GameParamsValidator.new(params)
        game_params_validator.validate

        game = create_game(params[:rows], params[:columns], params[:player_id], params[:mines])

        render_game_response(game)
      rescue Errors::InvalidArgumentError
        render_params_error_response
      end

      def show
        game = @game_service.find_by_id(params[:id])
        render json: GameRenderer.render_game_response(game), status: :ok
      rescue ArgumentError => e
        render_error_response(e)
      end

      def generate_text
        game = @game_service.find_by_id(params[:id])
        text = "#{game.player.name} - Game ID: #{game.id} - #{game.state}<br><br>"

        game.board.each do |row|
          row.each do |cell|
            if cell.revealed?
              if cell.mine?
                text << ' * '
              elsif cell.empty?
                text << ' · '
              else
                content = Cell.contents[cell.content.to_sym] - 1
                text << " #{content} "
              end
            else
              text << if cell.flagged?
                        ' F '
                      elsif cell.questioned?
                        ' ? '
                      else
                        ' O '
                      end
            end
          end
          text << '<br>'
        end

        render html: text.html_safe
      end

      def index
        games = @game_service.all
        render json: games, status: :ok
      end

      def flag
        perform_action(:flag)
      end

      def question
        perform_action(:question)
      end

      def reveal
        perform_action(:reveal)
      end

      private

      def render_game_response(game)
        if game.errors.any?
          render json: GameRenderer.render_errors_response(game.errors), status: :unprocessable_entity
        else
          render json: GameRenderer.render_game_response(game)
        end
      end

      def render_params_error_response
        render json: GameRenderer.render_params_error_response, status: :unprocessable_entity
      end

      def render_error_response(error)
        render json: GameRenderer.render_error_response(error), status: :unprocessable_entity
      end

      def create_game(rows, columns, player_id, mines)
        @game_service.create(rows, columns, player_id, mines)
      end

      def perform_action(action)
        action_params_validator = ActionParamsValidator.new(params)
        action_params_validator.validate
        game = @game_service.send("#{action}_cell",
                                  params[:id],
                                  params[:cell_id],
                                  params[:player_id])

        render_game_response(game)
      rescue Errors::InvalidArgumentError
        render_params_error_response
      end
    end
  end
end
