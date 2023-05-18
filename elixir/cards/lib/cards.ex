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
    #list comprehension returns list of cards
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

  @doc """
  deal_hand
  params: list of cards aka deck and number of cards to deal
  returns: tuple of hand and new deck
  """
  def deal_hand(deck, handsize) do
    #Enum.split returns tuple of two lists breaks it out into two variables
    Enum.split(deck, handsize)
  end

  @doc """
  game_start
  params: none
  returns: tuple of hand and new deck
  """
  def game_start do
    deck = create_deck()
    shuffled_deck = shuffle_deck(deck)
    {player1, newdeck} = deal_hand(shuffled_deck, 5)
    { _ , gamedeck } = deal_hand(newdeck, 5) #cpu hand
    "player1 hand: #{player1} \n game deck: #{gamedeck}"
  end

  @doc """
  save_game save game state to file
  params: deck, player1, player2
  returns: none
  """
  def save_game(deck, player1, player2) do
    # to_binary returns a binary representation of the term
    bin = :erlang.term_to_binary({deck, player1, player2})
    File.write("elixir_game", bin )
  end

  @doc """
  load_game load game state from file
  params: none
  returns: tuple of deck, player1, player2
  """
  def load_game do
    # read file into binary
    {status, bin} = File.read("elixir_game")
    case status do
      # binary_to_term converts binary to term ready for pattern matching
      :ok -> :erlang.binary_to_term(bin)
      :error -> "file not found"
    end
  end

end
