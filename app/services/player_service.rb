# frozen_string_literal: true

# Player Service Business Logic
class PlayerService
  include Dependencies[:player_repository]

  def find_or_create(name)

    player = @player_repository.find_by_name(name.downcase)

    return [player, false] if player

    created_player = @player_repository.create(name.downcase)
    [created_player, true]
  end

  def find_by_id(id)
    @player_repository.find_by_id(id)
  end
end
