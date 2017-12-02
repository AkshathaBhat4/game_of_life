class World < ApplicationRecord
  has_many :cells, dependent: :destroy
  has_many :living_cells, -> {where(status: 'live')}, class_name: 'Cell'

  def tick!
    die_cells = check_for_living_cells
    live_cells = check_for_dead_cells

    kill_all_cells!(die_cells)
    make_live_cells!(live_cells)
    self.generation_count += 1
    self.save
    update_coordinates
  end

  def find_live_cell_coordinates
    living_cells.inject({}) do |cell_coordinates, cell|
      cell_coordinates[cell.x.to_s] = {} if cell_coordinates[cell.x].blank?
      cell_coordinates[cell.x.to_s][cell.y.to_s] = true
      cell_coordinates
    end
  end

  def update_coordinates_for(x, y)
    self.top_x = x + 1 if top_x <= x
    self.bottom_x = x - 1 if bottom_x >= x
    self.top_y = y + 1 if top_y <= y
    self.bottom_y = y - 1 if bottom_y >= y
    self.save
  end

  def x_axis_min_max
    axis_min_max(top_x)
  end

  def y_axis_min_max
    axis_min_max(bottom_y)
  end

  def update_pattern_cells(pattern_id)
    pattern = Pattern.find_by(id: pattern_id)

    self.cells.destroy_all if self.cells.present?
    default_state = JSON.parse(pattern.default_state)
    reset_coordinates
    default_state.each do |x, y|
      self.cells.create(x: x, y: y)
    end
    self.generation_count = 0
    self.save
  end

  private

  def reset_coordinates
    self.top_x = 0
    self.bottom_x = 0
    self.top_y = 0
    self.bottom_y = 0
    self.save
  end

  def update_coordinates
    cells_x = self.living_cells.pluck(:x)
    cells_y = self.living_cells.pluck(:y)
    if cells_x.blank? || cells_y.blank?
      reset_coordinates
    else
      self.top_x = cells_x.max + 1
      self.bottom_x = cells_x.min - 1
      self.top_y = cells_y.max + 1
      self.bottom_y = cells_y.min - 1
      self.save
    end
  end

  def axis_min_max(axis_value)
    min, max = -14, 15
    if axis_value >= max
      max = axis_value + 1
      min = max - 30
    elsif axis_value <= min
      min = axis_value - 1
      max = min + 30
    end
    {min: min, max: max}
  end

  def check_for_living_cells
    living_cells.map{ |cell| cell.id unless [2, 3].include?(cell.neighbours.count) }.compact
  end

  def check_for_dead_cells
    live_cell_coordinates = find_live_cell_coordinates
    (self.bottom_x..self.top_x).inject([]) do |live_cells, x|
      (self.bottom_y..self.top_y).each do |y|
        unless live_cell_coordinates[x.to_s].try(y.to_s).present?
          live_cells << [x, y] if living_cells.neighbours_for(x, y).count == 3
        end
      end
      live_cells
    end
  end

  def kill_all_cells!(cell_ids)
    self.cells.where(id: cell_ids).update_all({status: 'dead'})
  end

  def make_live_cells!(cell_coordinates)
    cell_coordinates.each do |new_x, new_y|
      self.cells.where(x: new_x, y: new_y).first_or_create.update(status: 'live')
    end
  end
end
