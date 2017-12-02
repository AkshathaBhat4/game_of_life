class Cell < ApplicationRecord
  belongs_to :world
  attr_accessor :all_neighbours
  scope :neighbours_for, ->(x, y){where({x: [x - 1, x, x + 1], y: [y - 1, y, y + 1], status: 'live'})}

  after_create :update_world_coordinates

  def spawn_at(new_x, new_y)
    world.cells.create(x: new_x, y: new_y)
  end

  def neighbours
    world.cells.where({x: [self.x - 1, self.x, self.x + 1], y: [self.y - 1, self.y, self.y + 1], status: 'live'}).where.not(cells: {id: self.id})
  end

  def alive?
    status == 'live'
  end

  def dead?
    status == 'dead'
  end

  def die!
    self.update_attribute(:status, 'dead')
  end

  def update_world_coordinates
    world.update_coordinates_for(self.x, self.y)
  end
end
