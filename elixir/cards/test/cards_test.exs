defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck" do
    deck = Cards.create_deck()
    {hand, _new_deck} = Cards.deal_card(deck)
    assert "Ace of C " == hand
  end

  test "score card" do
    card = "King of C"
    assert 10 == Cards.retrieve_card_value(card)
  end

  test "hand score" do
    hand = ["8 of C", "King of D", "2 of H"]
    assert Cards.score_hand(hand, 1) == 20
  end


end
