module Magic
  module Cards
    RambunctiousMutt = Creature("Rambunctious Mutt") do
      cost generic: 3, green: 2
      creature_type("Dog")
      keywords :deathtouch
      power 2
      toughness 2
    end

    class RambunctiousMutt < Creature
      class ETB < TriggeredAbility::EnterTheBattlefield
        def perform
          effect = Effects::DestroyTarget.new(
            source: permanent,
            choices: game.battlefield.cards.by_any_type("Artifact", "Enchantment").not_controlled_by(controller)
          )
          game.add_effect(effect)
        end
      end

      def etb_triggers = [ETB]
    end
  end
end
