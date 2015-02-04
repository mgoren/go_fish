require('spec_helper')

describe(Player) do
  it {should have_and_belong_to_many :cards}
  it {should belong_to :game}
  it {should validate_presence_of :name}

  describe "#check_doubles" do
    it "will check a players hand for pairs" do
      player1 = Player.create(score: 0)
      card1 = Card.create(fish: "swordfish", :dealt => false)
      card2 = Card.create(fish: "swordfish", :dealt => false)
      card3 = Card.create(fish: "mikefish", :dealt => false)
      player1.cards << card1
      player1.cards << card2
      player1.cards << card3
      player1.check_doubles
      expect(player1.cards).to eq([card3])
    end
    it "will check a players hand for both pairs" do
      player1 = Player.create(score: 0)
      card1 = Card.create(fish: "swordfish", :dealt => false)
      card2 = Card.create(fish: "swordfish", :dealt => false)
      card3 = Card.create(fish: "mikefish", :dealt => false)
      card4 = Card.create(fish: "mikefish", :dealt => false)
      card5 = Card.create(fish: "benjaminfish", :dealt => false)
      player1.cards << card1
      player1.cards << card2
      player1.cards << card3
      player1.cards << card4
      player1.cards << card5
      player1.check_doubles
      player1.check_doubles
      expect(player1.cards).to eq([card5])
    end
  end

  describe('#get_card') do
    it('will deal a player a card') do
      card1 = Card.create(fish: "beardfish", dealt: false)
      player1 = Player.create()
      player1.get_card(1)
      expect(player1.cards.first.dealt).to eq(true)
    end
  end

  describe('#ask_for') do
    it('will ask an opponent if they have a certain card') do
      card1 = Card.create(fish: "beardfish")
      card2 = Card.create(fish: "beardfish")
      card3 = Card.create(fish: "jellyfish")
      player1 = Player.create()
      player2 = Player.create()
      player1.cards.push(card1)
      player2.cards.push(card2, card3)
      player1.ask_for(player2, card1.fish)
      expect(player2.cards()).to eq([card3])
    end
    it('will ask an opponent if they have a certain card') do
      card1 = Card.create(fish: "beardfish")
      card2 = Card.create(fish: "beardfish")
      card3 = Card.create(fish: "jellyfish")
      player1 = Player.create()
      player2 = Player.create()
      player1.cards.push(card1)
      player2.cards.push(card2, card3)
      player1.ask_for(player2, card1.fish)
      expect(player1.cards()).to eq([card1, card2])
    end
  end

  describe(:capitalize_name) do
    it("will capitalize name") do
      player1 = Player.create({:name => "mike goren"})
      expect(player1.name()).to(eq("Mike Goren"))
    end
  end



end
