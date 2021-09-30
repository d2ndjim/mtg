module Magic
  class StaticAbilities < SimpleDelegator
    def add(ability)
      self << ability
    end

    def remove(ability)
      ability.remove
      delete(ability)
    end

    def select(...)
      self.class.new(super(...))
    end

    def from(card)
      select { |ability| ability.source == card }
    end

    def applies_to(card)
      select { |ability| ability.applies_to?(card) }
    end
  end
end
