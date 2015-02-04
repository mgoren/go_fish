class Player < ActiveRecord::Base

  has_and_belongs_to_many :cards
  belongs_to :game
  validates_presence_of :name
  before_save :capitalize_name

  default_scope {order('player_num')}

  def check_doubles
    hand = self.cards
    fishes = []
    hand.each do |card|
      fishes << card.fish
    end
    fishes.detect{|fish| fishes.count(fish) == 2}
  end

  def score_double(fish)
    hand = self.cards
    selected_cards = hand.select {|card| card.fish == fish}
    if selected_cards.length == 2
      new_score = self.score + 1
      self.update(score: new_score)
      hand.each do |card|
        if card.fish == fish
          hand.delete(card)
        end
      end
      # self.cards.where(fish: detected).delete
    end
  end

  def get_card (number)
    number.times do
      if Card.not_dealt.any?
        card = Card.not_dealt.order("RANDOM()").first
        card.update(dealt: true)
        self.cards.push(card)
      end
    end
  end

  def ask_for (opponent, my_card)
    opponent.cards.each() do |card|
      if card.fish == my_card
        self.cards.push(card)
        opponent.cards.delete(card)
      end
    end
  end


  private

  define_method(:capitalize_name) do
    self.name=(name.split(/(\W)/).map(&:capitalize).join)
  end

end
