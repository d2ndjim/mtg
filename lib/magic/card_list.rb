module Magic
  class CardList < SimpleDelegator
    def controlled_by(player)
      self.class.new(select { |card| card.controller == player })
    end

    def creatures
      self.class.new(select(&:creature?))
    end

    def apply_ability(ability)
      applicable_cards = select { |card| ability.applies_to?(card) }
      applicable_cards.each { |card| ability.apply(card) }
    end
  end
end
