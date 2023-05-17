defmodule Cards do
  @moduledoc """
  simple cards console app
  """

  @doc """
  Hello world.
  """
  def hello do
    "hello, there"
  end

  @doc """
  creates deck of cards in order, prints to console
  returns: list of cards
  note: implicit return
  """
  def create_deck do
    suits = ["Clubs", "Diamonds", "Hearts", "Spades"]
    values = ["Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10",
              "Jack", "Queen", "King"]
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
  shuffles deck of cards
  params: deck - list of cards
  returns: shuffled deck
  Note: Enum.shuffle returns a new list
  """
  def shuffle_deck(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  contains_card
  params: list of cards and card to find
  returns: true if card is in list, false otherwise
  """
  def contains_card(cards, card) do
    Enum.member?(cards, card)
  end


end
