require 'minitest/autorun'
require 'minitest/pride'
require_relative 'tennis_scores'

class TennisScoresTest < Minitest::Test

  def test_it_exists
    assert_kind_of Class, TennisScores
  end

  def test_score_outputs_score_of_zero_for_empty_string
    input = ''
    assert_equal TennisScores.compute_score(input)[:current_game]['A'], 'love'
    assert_equal TennisScores.compute_score(input)[:current_game]['B'], 'love'
  end

  def test_two
    input = 'A'
    assert_equal TennisScores.compute_score(input)[:current_game]['A'], '15'
    assert_equal TennisScores.compute_score(input)[:current_game]['B'], 'love'
  end

  def test_three
    input = 'BBB'
    output = {'A' => 'love', 'B' => '40'}
    assert_equal TennisScores.compute_score(input)[:current_game], output
  end

  def test_four
    input = 'ABAB'
    output = {'A' => '30', 'B' => '30'}
    assert_equal TennisScores.compute_score(input)[:current_game], output
  end

  def test_game_is_won_by_player_a
    input = 'AAAA'
    output = {
      current_game: {
        'A' => 'love',
        'B' => 'love'
      },
      game_score: {
        'A' => 1,
        'B' => 0
      },
      set_score: {
        'A' => 0,
        'B' => 0
      }
    }
    assert_equal TennisScores.compute_score(input), output
  end

  def test_game_is_won_by_player_b
    input = 'BBBBB'
    output = {
      current_game: {
        'A' => 'love',
        'B' => '15'
      },
      game_score: {
        'A' => 0,
        'B' => 1
      },
      set_score: {
        'A' => 0,
        'B' => 0
      }
    }
    assert_equal TennisScores.compute_score(input), output
  end

  def test_game_is_won_by_player_b_with_mixed_scoring
    input = 'BABABBBA'
    output = {
      current_game: {
        'A' => '15',
        'B' => '15'
      },
      game_score: {
        'A' => 0,
        'B' => 1
      },
      set_score: {
        'A' => 0,
        'B' => 0
      }
    }
    assert_equal TennisScores.compute_score(input), output
  end

  def test_two_games_are_won_by_player_b_with_mixed_scoring
    input = 'BABABBBABBB'
    output = {
      current_game: {
        'A' => 'love',
        'B' => 'love'
      },
      game_score: {
        'A' => 0,
        'B' => 2
      },
      set_score: {
        'A' => 0,
        'B' => 0
      }
    }
    assert_equal TennisScores.compute_score(input), output
  end

  def test_set_won_by_player_b
    input = 'BBBBBBBBBBBBBBBBBBBBBBBB'
    output = {
      current_game: {
        'A' => 'love',
        'B' => 'love'
      },
      game_score: {
        'A' => 0,
        'B' => 0
      },
      set_score: {
        'A' => 0,
        'B' => 1
      }
    }
    assert_equal TennisScores.compute_score(input), output
  end
end
