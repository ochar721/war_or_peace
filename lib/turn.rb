class Turn
  attr_reader :player1,
              :player2,
              :spoils_of_war,
              :winner

  def initialize(player1, player2)
    @player1       = player1
    @player2       = player2
    @spoils_of_war = []
  end

  def type
    if player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0) &&
       player1.deck.rank_of_card_at(2) == player2.deck.rank_of_card_at(2)
        :mutually_assured_destruction
    elsif player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0)
        :war
    else player1.deck.rank_of_card_at(0) != player2.deck.rank_of_card_at(0)
        :basic
    end
  end

  def basic_winner
    if player1.deck.rank_of_card_at(0) > player2.deck.rank_of_card_at(0)
      player1
    else player1.deck.rank_of_card_at(0) < player2.deck.rank_of_card_at(2)
      player2
    end
  end

  def war_winner
    if player1.deck.rank_of_card_at(2) > player2.deck.rank_of_card_at(2)
      player1
    else player1.deck.rank_of_card_at(2) < player2.deck.rank_of_card_at(2)
      player2
    end
  end

  def winner
    if  type == :mutually_assured_destruction
      p "No Winner"
    elsif type == :war
      war_winner
    else type == :basic
       basic_winner
    end
  end

  def pile_cards
    if type == :mutually_assured_destruction
      player1.deck.remove_card(3)
      player2.deck.remove_card(3)
    elsif type == :war
      @spoils_of_war << player1.deck.remove_card(3)
      @spoils_of_war << player2.deck.remove_card(3)
    else type == :basic
      @spoils_of_war << player1.deck.remove_card
      @spoils_of_war << player2.deck.remove_card
    end
  end

  def award_spoils(winner)
    winner.deck.add_card(@spoils_of_war)
  end
end
