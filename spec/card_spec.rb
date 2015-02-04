require('spec_helper')

describe Card do
  it 'will add the cards to our deck' do
    Card.add_cards()
    expect(Card.all.length()).to eq(22)
  end

  describe('.not_dealt') do
    it 'will return the cards that have not yet been dealt' do
      card1 = Card.create(fish: "fruitfish", dealt: false)
      card2 = Card.create(fish: "veggiefish", dealt: true)
      expect(Card.not_dealt()).to eq([card1])
    end
  end

  # it 'will not be in the same order as in the table' do
  #   card1 = Card.create(fish: "fruitfish", dealt: false)
  #   card2 = Card.create(fish: "veggiefish", dealt: false)
  #   card3 = Card.create(fish: "dogfish", dealt: false)
  #   card4 = Card.create(fish: "catfish", dealt: false)
  #   card5 = Card.create(fish: "shrimp", dealt: false)
  #   card_array = [card1, card2, card3, card4, card5]
  #   expect(Card.all() == card_array).to eq(false)
  # end

  describe('#alphabetize') do
    it('will alphabetize the cards') do
      card1 = Card.create(fish: "veggiefish", dealt: false)
      card2 = Card.create(fish: "fruitfish", dealt: false)
      cards = [card1, card2]
      expect(Card.all.alphabetize).to eq([card2, card1])
    end
  end
end
