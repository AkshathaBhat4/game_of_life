class HomeController < ApplicationController
  def index
    @patterns = Pattern.all
  end

  def next_generation
    @world = World.find_by(id: params[:id])
    @world.tick!
    render json: world_points
  end

  # Accepted Params
  # id: Integer
  # => Pattern Id
  # world_id: Integer
  #
  # It Created Or Updated the world depending on world_id parameter
  def update_world
    # pattern = Pattern.find_by(id: params[:id])
    @world = World.find_by(id: params[:world_id]) if params[:world_id].present?
    @world = World.create if @world.blank?

    @world.update_pattern_cells(params[:id])
    @world.reload
    render json: world_points
  end

  private

  def world_points
    @world = World.first if @world.blank?
    {
      data: @world.living_cells.map{|cell| [cell.x, cell.y]},
      x_axis: @world.x_axis_min_max,
      y_axis: @world.y_axis_min_max,
      world_id: @world.id,
      generation_count: @world.generation_count
    }
  end
end
