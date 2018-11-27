-module(yatzy).

-type slot() :: 'ones' | 'twos' | 'threes' | 'fours' | 'fives' | 'sixes' | 'one pair' | 'two pairs' | 'three of a kind' |  'four of a kind' |  'small straight' |  'large straight' |  'full house' |  'chance' | 'yatzy'.

-type slot_type() :: 'upper' | 'lower'.

-type roll() :: [1..6].
