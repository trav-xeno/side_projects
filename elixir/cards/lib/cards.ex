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
  note reminder: implicit return
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
    Enum.reduce(hand, 0, fn card, score ->
      if String.contains?(card, "Ace") do
        score + ace_value
      else
        score + retrieve_card_value(card)
      end
    end)
  end

  @doc """
  hit_or_stay prompts user to hit or stay
  params: none
  returns: true if hit, false if stay
  """
  def hit_or_stay do
    IO.puts("Hit or Stay?")
    answer = IO.gets(" |> ") |> String.trim() |> String.downcase()
    if answer == "hit" || answer == "hit me" do
      true
    else
      false
    end
  end

  @doc """
  compare_scores compares scores of player and cpu
  params: player score, cpu score
  returns: true if player wins, false if cpu wins
  """
  def compare_scores(player_score, cpu_score) do

    if player_score > cpu_score do
      true
    else
      false
    end
  end

  @doc """
  reveal_hand reveals hand and determines winner
  params: deck, player1, cpu
  returns: none
  """
  def reveal_hand(player1, cpu) do
    IO.puts("Player1 hand: #{player1}")
    IO.puts("Player1 score: #{score_hand(player1, 1)}" )
    IO.puts("CPU hand: #{cpu}")
    IO.puts("CPU score: #{score_hand(cpu, 1)}")
    if score_hand(player1, 1) > 21 do
      IO.puts("Player1 busts")
      IO.puts("CPU wins")
    else
      if score_hand(cpu, 1) > 21 do
        IO.puts("CPU busts")
        IO.puts("Player1 wins")
      else
        if score_hand(player1, 1) == score_hand(cpu, 1) do
          IO.puts("Its a push neither player wins")
        else
          if compare_scores(score_hand(player1, 1), score_hand(cpu, 1)) do
            IO.puts("Player1 wins")
          else
           IO.puts("CPU wins")
          end
        end
      end
    end
  end

  @doc """
  cpu_turn handle dealer turn
  params: deck, cpu
  returns: {newdeck, newcpuhand}
  """
  def cpu_turn(deck, cpu) do
    if score_hand(cpu, 1) < 17 do
      {cpuCard, newdeck} = deal_card(deck)
      newcpu = cpu ++ [cpuCard]
      IO.puts("CPU hand: #{newcpu} score: #{score_hand(cpu, 1)}")
      {newdeck, newcpu}
    else
      IO.puts("CPU score: #{score_hand(cpu, 1)}")
      {deck, cpu}
    end

  end



  @doc """
  game_loop loops through game
  params: deck, player1, cpu
  returns: none
  """
  def game_loop(deck, player1, cpu) do
    IO.puts("Player1 hand: #{player1}")
    IO.puts("Player1 score: #{score_hand(player1, 1)}")
    if hit_or_stay() do
      {card, newdeck} = deal_card(deck)
      newhand = player1 ++ [card]
      IO.puts("Cpu hand: #{cpu}")
      {newdeck2 , newcpu}  = cpu_turn(newdeck, cpu)
      if score_hand(newhand, 1) > 21 do
        IO.puts("Player1 busts")
        IO.puts("CPU wins")
      else
        game_loop(newdeck2, newhand, newcpu)
      end
    else
      cpu_turn(deck, cpu)
      reveal_hand(player1, cpu)
    end
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
    { cpu , gamedeck } = deal_hand(newdeck, 2) #cpu hand
    IO.puts("CPU frist card: #{List.first(cpu)}")
    game_loop(gamedeck, player1, cpu)
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
