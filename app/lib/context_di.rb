# frozen_string_literal: true

require 'dry/container'
require 'dry/auto_inject'

# Context Container
class Container
  extend Dry::Container::Mixin
  # Services
  register(:player_service) { PlayerService.new }
  register(:game_service) { GameService.new }
  register(:cell_service) { CellService.new }

  # Repositories
  register(:player_repository) { PlayerRepository.new }
  register(:game_repository) { GameRepository.new }
  register(:cell_repository) { CellRepository.new }
end

Dependencies = Dry::AutoInject(Container)
