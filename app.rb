require("bundler/setup")
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get "/" do
  Card.all().each() do |x|
    x.destroy()
  end
  Player.all().each() do |x|
    x.destroy()
  end
  Game.all().each() do |x|
    x.destroy()
  end
  erb(:index)
end

post "/game" do
  @game = Game.create
  if params['name1'] != ""
    @game.players.create(name: params['name1'], player_num: 1, score: 0)
  end
  if params['name2'] != ""
    @game.players.create(name: params['name2'], player_num: 2, score: 0)
  end
  if params['name3'] != ""
    @game.players.create(name: params['name3'], player_num: 3, score: 0)
  end
  if params['name4'] != ""
    @game.players.create(name: params['name4'], player_num: 4, score: 0)
  end
  @game.start
  erb(:score)
end

get "/player/:player_num" do
  @player = Player.find_by(player_num: params["player_num"])
  @game = Game.first
  if @player.cards.length == 0
    @fail = true
  end
  erb(:player)
end

post "/check_doubles" do
  @game = Game.first
  player = Player.find(@game.player_id)
  num = player.player_num
  player.check_doubles

  if @game.gameover
    erb(:score)
  else
    redirect("/player/#{num}")
  end
end

post "/ask" do
  @game = Game.first
  @player = Player.find(@game.player_id)
  original_cards = @player.cards.length
  opp = Player.find(params['opponent'])
  fish = params['card']
  @player.ask_for(opp, fish)
  new_cards = @player.cards.length
  if new_cards > original_cards
    @success = true
  else
    @fail = true
  end

  erb(:player)
end

post "/go_fish" do
  game = Game.first
  player = Player.find(game.player_id)
  num = player.player_num
  player.get_card(1)
  @game = Game.first
  @game.update_turn
  erb :score
end


get "/reset" do
  erb(:oil_spill)
end
