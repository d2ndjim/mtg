module Magic
  module Abilities
    module Static
      class ReduceManaCost
        attr_reader :source, :reduction, :applies_to
        def initialize(source:, reduction:, applies_to:)
          @source = source
          @reduction = reduction
          @applies_to = applies_to
        end

        def applies_to?(card)
          applies_to.call(card)
        end

        def applies_while_entering_the_battlefield?
          false
        end

        def apply(cost)
          @reduction.each do |mana, count|
            cost[mana] -= count
            cost[mana] = 0 if cost[mana] < 0
          end
        end

        def remove
        end
      end
    end
  end
end
