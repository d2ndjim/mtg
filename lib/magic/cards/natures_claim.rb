module Magic
  module Cards
    class NaturesClaim < Instant
      NAME = "Nature's Claim"
      COST = { green: 1 }

      def resolve!
        game.add_effect(
          Effects::DestroyControllerGainsLife.new(
            valid_targets: -> (c) { c.enchantment? || c.artifact? },
          )
        )
        super
      end
    end
  end
end