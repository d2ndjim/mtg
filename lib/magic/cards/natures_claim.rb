module Magic
  module Cards
    NaturesClaim = Instant("Nature's Claim") do
      cost green: 1
    end

    class NaturesClaim < Instant
      def single_target?
        true
      end

      def target_choices
        battlefield.permanents.by_any_type("Enchantment", "Artifact")
      end

      def resolve!(_controller, target:)
        target.destroy!
        target.controller.gain_life(4)

        super
      end
    end
  end
end
