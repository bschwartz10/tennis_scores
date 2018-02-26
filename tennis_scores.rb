class TennisScores

  TENNIS_SCORES = {
    0 => 'love',
    1 => '15',
    2 => '30',
    3 => '40'
  }

  def self.compute_score(input)
    initial_scores = {
      'A' => 0,
      'B' => 0
    }

    output = {
      current_game: initial_scores,
      game_score: initial_scores.dup,
      set_score: initial_scores.dup
    }

    input.chars.each do |letter|
      if game_won?(output, letter)
        if set_won?(output, letter)
          win_set(output, letter)
          reset_game_scores(output)
          reset_player_scores(output)
        else
          win_game(output, letter)
          reset_player_scores(output)
        end
      else
        point_won(output, letter)
      end
    end
    convert_scores(output)
  end

  def self.reset_player_scores(output)
    output[:current_game].each do |player, score|
      output[:current_game][player] = 0
    end
  end

  def self.reset_game_scores(output)
    output[:game_score].each do |player, score|
      output[:game_score][player] = 0
    end
  end

  def self.game_won?(output, letter)
    output[:current_game][letter] == 3
  end

  def self.set_won?(output, letter)
    output[:game_score][letter] == 5
  end

  def self.win_set(output, letter)
    output[:set_score][letter] += 1
  end

  def self.win_game(output, letter)
    output[:game_score][letter] += 1
  end

  def self.point_won(output, letter)
    output[:current_game][letter] += 1
  end

  def self.convert_scores(output)
    result = output[:current_game].reduce({}) do |agg, (player, score)|
      agg[player] = TENNIS_SCORES[score]
      agg
    end
    output[:current_game] = result
    output
  end

end
