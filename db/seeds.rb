# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

patterns = {
  block: [[-1, 1], [0, 1], [0, 0], [-1, 0]],
  boat: [[-1, 1], [0, 1], [-1, 0], [1, 0], [0, -1]],
  loaf: [[-1, 1], [0, 2], [1, 2], [2, 1], [2, 0], [1, -1], [0, 0]],
  beehive: [[-1, 0], [0, 1], [1, 1], [2, 0], [1, -1], [0, -1]],
  tub: [[-1, 0], [0, 1], [1, 0], [0, -1]],
  blinker: [[0, 1], [0, 0], [0, -1]],
  beacon: [[-1, 0], [-1, 1], [0, 1], [2, -1], [2, -2], [1, -2]],
  toad: [[0,1], [1, 1], [2, 1], [-1, 0], [0, 0], [1, 0]],
  pulsar: [
    [1, 4], [1, 3], [1, 2], [1, -2], [1, -3], [1, -4],
    [-1, 4], [-1, 3], [-1, 2], [-1, -2], [-1, -3], [-1, -4],
    [6, 4], [6, 3], [6, 2], [6, -2], [6, -3], [6, -4],
    [-6, 4], [-6, 3], [-6, 2], [-6, -2], [-6, -3], [-6, -4],
    [-4, 1], [-3, 1], [-2, 1], [2, 1], [3, 1], [4, 1],
    [-4, -1], [-3, -1], [-2, -1], [2, -1], [3, -1], [4, -1],
    [-4, 6], [-3, 6], [-2, 6], [2, 6], [3, 6], [4, 6],
    [-4, -6], [-3, -6], [-2, -6], [2, -6], [3, -6], [4, -6],
  ],
  pentadecathlon: [
    [0, 8], [0, 7], [0, 6], [-1, 6], [1, 6], [-1, 3], [0, 3], [1, 3],
    [0, 2], [0, 1], [0, 0], [0, -1], [-1, -2], [0, -2], [1, -2],
    [-1, -5], [0, -5], [1, -5], [0, -6], [0, -7]
  ],
  glider: [[-1, 1], [0, 0], [1, 0], [-1, -1], [0, -1]],
  spaceship: [
    [-1, 2], [0, 2], [-2, 1], [-1, 1], [0, 1], [1, 1],
    [-2, 0], [-1, 0], [1, 0], [2, 0], [0, -1], [1, -1]
  ]
}

Pattern.create(patterns.map{|name, coordinates| {name: name, default_state: coordinates} })
