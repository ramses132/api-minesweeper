# Player Repository
class PlayerRepository < PlayerRepositoryInterface
  def find_by_name(name)
    Player.find_by_name(name)
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def find_by_id(id)
    Player.find(id)
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def create(attributes)
    Player.create(attributes)
  end
end
