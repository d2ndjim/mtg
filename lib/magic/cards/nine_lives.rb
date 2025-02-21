module Magic
  module Cards
    NineLives = Enchantment("Nine Lives") do
      type "Legendary Enchantment -- Shrine"
      cost generic: 1, white: 2
      keywords :hexproof
    end

    class NineLives < Enchantment
      def replacement_effects
        {
          Events::LifeLoss => -> (receiver, event) do
            effect = Effects::AddCounter.new(
              source: receiver,
              counter_type: Counters::Incarnation,
              choices: [receiver],
              targets: [receiver]
            )
            game.add_effect(effect)
          end
        }
      end

      def event_handlers
        {
          Events::LeavingZone => -> (receiver, event) do
            return unless event.from.battlefield?

            receiver.controller.lose!
          end,
          Events::CounterAdded => -> (receiver, event) do
            if receiver.counters.of_type(Counters::Incarnation).count >= 9
              Effects::Exile.new(source: receiver).resolve(target: receiver)

              loss_event = Events::PlayerLoses.new(
                player: receiver.controller,
              )

              game.notify!(loss_event)
            end
          end
        }
      end
    end
  end
end
