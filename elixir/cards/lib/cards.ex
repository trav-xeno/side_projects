defmodule Cards do
  @moduledoc """
  simple cards console app playing blackjack
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
    suits = ["C", "D", "H", "S"]
    values = ["Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10",
              "Jack", "Queen", "King"]
    #list comprehension returns list of cards
    for suit <- suits, value <- values do
      "#{value} of #{suit} "
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
  deal_card deals a single card from deck
  params: deck
  returns: tuple of card and new deck
  """
  def deal_card(deck) do
    #Enum.take returns a list of the first n elements
    #Enum.at returns the element at index n
    card = Enum.at(deck, 0)
    newdeck = Enum.drop(deck, 1)
    {card, newdeck}
  end


  @doc """
  retrieve_card_value
  params: card
  returns: value of card
  """
  def retrieve_card_value(card) do
    face_cards = ["King","Queen","Jack"]
    if String.contains?(card,face_cards) do
      10
    else
        String.to_integer(String.slice(card, 0..1) |> String.trim())
      end
  end


@doc """
  score_hand
  params: hand, ace value
  returns: score of hand
  """
  def score_hand(hand, ace_value) do
    #Enum.reduce returns the result of applying a function to each element
    #in the list
    Enum.reduce(hand, 0, fn card, score ->
      #String.contains? returns true if card contains ace
      if String.contains?(card, "Ace") do
        score + ace_value
      else
        #String.to_integer converts string to integer
        score + retrieve_card_value(card)
      end
    end)
  end

  @doc """
  test_score_hand
  params: none
  returns: score of hand
  """
  def test_score_hand do
    hand = ["8 of C", "King of D", "2 of H"]
    score_hand(hand, 1)
  end



  @doc """
  game_start
  params: none
  returns: tuple of hand and new deck
  after reading the code realized I should have used pipe operator
  """
  def game_start do
    shuffled_deck = create_deck()
                      |> shuffle_deck()
    {player1, newdeck} = deal_hand(shuffled_deck, 2)
    { _cpu , gamedeck } = deal_hand(newdeck, 2) #cpu hand
    "player1 hand: #{player1} \n game deck: #{gamedeck}"
  end

  @doc """
  save_game save game state to file
  params: deck, player1, player2
  returns: none
  """
  def save_game(deck, player1, cpu) do
    # to_binary returns a binary representation of the term
    bin = :erlang.term_to_binary({deck, player1, cpu})
    File.write("elixir_game", bin )
  end

  @doc """
  load_game load game state from file
  params: none
  returns: tuple of deck, player1, player2
  remind to futureself :ok and :error is called atom
  """
  def load_game do
    # read file into binary could make this a single case statement
    {status, bin} = File.read("elixir_game")
    case status do
      # could wrtie {:ok, bin} -> :erlang.binary_to_term(bin) if case was file.read
      # binary_to_term converts binary to term ready for pattern matching
      :ok -> :erlang.binary_to_term(bin)
      :error -> "file not found"
    end
  end

end
