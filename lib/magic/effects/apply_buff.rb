module Magic
  module Effects
    class ApplyBuff < Effect
      attr_reader :power, :toughness

      def initialize(power: 0, toughness: 0, **args)
        @power = power
        @toughness = toughness
        super(**args)
      end

      def multiple_targets?
        true
      end

      def requires_choices?
        true
      end

      def resolve(targets:)
        raise InvalidTarget if targets.any? { |target| !choices.include?(target) }

        targets.each do |target|
          target.modifiers << Cards::Creature::Buff.new(power: power, toughness: toughness)
        end
      end
    end
  end
end