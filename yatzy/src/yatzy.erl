-module(yatzy).

-type slot() :: 'ones' | 'twos' | 'threes' | 'fours' | 'fives' | 'sixes' | 'one_pair' | 'two_pairs' | 'three_of_a_kind' |  'four_of_a_kind' | 'small_straight' | 'large_straight' | 'full_house' | 'chance' | 'yatzy'.

-type slot_type() :: 'upper' | 'lower'.

-type roll() :: [1..6].
