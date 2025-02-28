module Magic
  module Cards
    AltarsLight = Instant("Altar's Light") do
      cost generic: 2, white: 2
    end

    class AltarsLight < Instant
      def single_target?
        true
      end

      def target_choices
        battlefield.cards.by_any_type("Artifact", "Enchantment")
      end

      def resolve!(_controller, target:)
        Effects::Exile.new(source: self).resolve(target: target)
      end
    end
  end
end
