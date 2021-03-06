== Game Of Life
This is a Rails implementation of "Conway's Game of Life." Conway's game is a mathematical simulation where cells live or die based on certain rules.

== See it in action!

You can try Game Of Life live at this url: http://gol.akshathabhat.co.in/

== Rules
The universe of the Game of Life is an infinite two-dimensional orthogonal grid of square cells, each of which is in one of two possible states, live or dead. Every cell interacts with its eight neighbours, which are the cells that are horizontally, vertically, or diagonally adjacent. At each step in time, the following transitions occur:

1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.
2. Any live cell with two or three live neighbours lives on to the next generation.
3. Any live cell with more than three live neighbours dies, as if by overcrowding.
4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

The initial pattern constitutes the seed of the system. The first generation is created by applying the above rules simultaneously to every cell in the seed—births and deaths occur simultaneously, and the discrete moment at which this happens is sometimes called a tick (in other words, each generation is a pure function of the preceding one). The rules continue to be applied repeatedly to create further generations.

== How To Play
1. Select Any pattern displayed in right side block
2. Select 'Start' to see all generation one by one / 'Next Generation' to just view its next generation
3. Select Stop to Stop the current generation cycle

== Contributing

1. Fork it ( https://github.com/[my-github-username]/game_of_life/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

== Installation
1. bundle
2. rake db:create RAILS_ENV=production
3. rake db:migrate RAILS_ENV=production
4. rake db:seed RAILS_ENV=production
5. rake assets:precompile RAILS_ENV=production

== Testing
rspec  --format documentation
