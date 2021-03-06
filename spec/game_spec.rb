require('spec_helper')

describe(Game) do

  it {should have_many :players}

  describe("#start") do
    it("will deal cards to players") do
      game1 = Game.create()
      player1 = Player.create(name: "fisherman")
      player2 = Player.create(name: "phisherman")
      game1.start()
      expect(player1.cards.length).to eq(5)
    end
  end

  describe("#gameover") do
    it("will check if the game is over") do
      game1 = Game.create()
      player1 = Player.create(name: "fisherman", score: 0)
      player2 = Player.create(name: "phisherman", score: 11)
      game1.start()
      expect(game1.gameover).to eq(true)
    end
  end

  describe("#update_turn") do
    it("will update the db with the correct turn") do
      game1 = Game.create()
      player1 = Player.create(name: "fisherman", player_num: 1)
      player2 = Player.create(name: "phisherman", player_num: 2)
      game1.start()
      game1.update_turn()
      expect(game1.player_id).to eq(player2.id)
    end
  end

  describe "#winner" do
    it "will recognize the player with the highest score" do
      game1 = Game.create()
      player1 = Player.create(name: "fisherman", player_num: 1, score: 6)
      player2 = Player.create(name: "disherman", player_num: 2, score: 11)
      game1.start()
      expect(game1.winner).to eq(player2)
    end
  end

end
