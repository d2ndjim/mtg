require 'spec_helper'

RSpec.describe Magic::Cards::JeskaiElder do
  include_context "two player game"

  subject! { ResolvePermanent("Jeskai Elder", owner: p1) }

  context "base power + toughness" do
    it "has an unmodified power + toughness" do
      expect(subject.power).to eq(1)
      expect(subject.toughness).to eq(2)
    end
  end

  context "when a non-creature spell has been cast" do
    before do
      p1.add_mana(green: 2)
      action = cast_action(player: p1, card: Card("Rampant Growth"))
        .pay_mana(green: 1, generic: { green: 1 })
        .perform
      game.tick!
    end

    it "has a boosted power + toughness" do
      expect(subject.power).to eq(2)
      expect(subject.toughness).to eq(3)
      buff = subject.modifiers.first
      expect(buff.power).to eq(1)
      expect(buff.toughness).to eq(1)
      expect(buff.until_eot?).to eq(true)
    end
  end

  context "when a creature spell has been cast" do
    before do
      p1.add_mana(green: 3)
      action = cast_action(player: p1, card: Card("Wood Elves"))
        .pay_mana(green: 1, generic: { green: 2 })
        .perform
      game.tick!
    end

    it "has a regular power and toughness" do
      expect(subject.power).to eq(1)
      expect(subject.toughness).to eq(2)
    end
  end
end
