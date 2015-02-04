class Card < ActiveRecord::Base

  has_and_belongs_to_many :players

  def self.add_cards
    fishes = ["dolphin", "whale", "shark", "swordfish", "blowfish", "onefish", "twofish", "redfish", "bluefish", "spongeBill", "starfish"]
    2.times do
      fishes.each do |fish|
        Card.create({:fish => fish, :dealt => false})
      end

    end
  end

  scope(:not_dealt, -> do
    where({:dealt => false})
  end)

  scope(:alphabetize, -> { order(:fish) })

end
