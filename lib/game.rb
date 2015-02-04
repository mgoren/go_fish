class Game < ActiveRecord::Base

  has_many :players

  def start
    @players = Player.all
    Card.add_cards
    @total_points = Card.all.length / 2 # not accessible from gameover method!
    @players.each do |player|
      player.get_card(5)
    end
    update(:player_id => @players.first.id)
  end

  def gameover
    total_score = 0
    Player.all.each do |player|
      total_score += player.score
    end
    if total_score == 11
      return true
    else
      return false
    end
  end

  def update_turn
    next_player_num = Player.find(self.player_id).player_num + 1
    if next_player_num > Player.all.length
      next_player_num = 1
    end
    next_player_id = (Player.find_by(player_num: next_player_num)).id
    update(player_id: next_player_id)
  end

  def winner
    players = Player.all.reorder(score: :desc)
    players.first
  end

end
