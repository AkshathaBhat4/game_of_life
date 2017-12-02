require 'rails_helper'

RSpec.describe Cell, type: :model do
  let(:world) {World.create}
  context 'cell utility methods' do
    subject { world.cells.create()}

    it 'cell default state to be alive' do
      expect(subject.alive?).to be true
      expect(subject.alive?).to be true
    end

    it 'cell should update its world co-ordinates' do
      expect(subject.world.top_x).to eq 1
      expect(subject.world.top_y).to eq 1
      expect(subject.world.bottom_x).to eq -1
      expect(subject.world.bottom_y).to eq -1
    end

    it 'spawn relative to' do
      cell = subject.spawn_at(3, 5)
      expect(cell).to be_instance_of(Cell)
      expect(cell.x).to eq(3)
      expect(cell.y).to eq(5)
      expect(cell.world).to eq(subject.world)
    end

    it 'detects a neighbour to the top' do
      cell = subject.spawn_at(0, 1)
      expect(subject.neighbours.count).to eq(1)
    end

    it 'detects a neighbour to the bottom' do
      cell = subject.spawn_at(0, -1)
      expect(subject.neighbours.count).to eq(1)
    end

    it 'detects a neighbour to the left' do
      cell = subject.spawn_at(-1, 0)
      expect(subject.neighbours.count).to eq(1)
    end

    it 'detects a neighbour to the right' do
      cell = subject.spawn_at(1, 0)
      expect(subject.neighbours.count).to eq(1)
    end

    it 'detects a neighbour to the top left' do
      cell = subject.spawn_at(-1, 1)
      expect(subject.neighbours.count).to eq(1)
    end

    it 'detects a neighbour to the bottom left' do
      cell = subject.spawn_at(-1, -1)
      expect(subject.neighbours.count).to eq(1)
    end

    it 'detects a neighbour to the top right' do
      cell = subject.spawn_at(1, 1)
      expect(subject.neighbours.count).to eq(1)
    end

    it 'detects a neighbour to the bottom right' do
      cell = subject.spawn_at(1, -1)
      expect(subject.neighbours.count).to eq(1)
    end

    it 'cell dies' do
      subject.die!
      expect(subject.dead?).to be true
      expect(world.living_cells).not_to include(subject)
    end
  end

  context "game of life" do
    it "Rule 1) Any live cell with fewer than two live neighbours dies, as if caused by underpopulation." do
      cell = world.cells.create
      cell.spawn_at(1,1)
      expect(cell.neighbours.count).to eq(1)
      world.tick!

      cell.reload
      world.reload

      expect(cell.dead?).to be true
      expect(world.living_cells).not_to include(cell)
    end

    it "Rule 2) Any live cell with more than three live neighbours dies, as if by overcrowding." do
      cell = world.cells.create
      cell.spawn_at(1,1)
      cell.spawn_at(0,1)
      cell.spawn_at(1,0)
      cell.spawn_at(-1,1)
      expect(cell.neighbours.count).to eq(4)
      world.tick!

      cell.reload
      world.reload

      expect(cell.dead?).to be true
      expect(world.living_cells).not_to include(cell)
    end

    it "Rule 3) Any live cell with two or three live neighbours lives on to the next generation." do
      cell = world.cells.create
      cell.spawn_at(1,1)
      cell.spawn_at(0,1)
      expect(cell.neighbours.count).to eq(2)
      world.tick!

      cell.reload
      world.reload

      expect(cell.alive?).to be true
      expect(world.living_cells).to include(cell)
    end

    it "Rule 4) Any dead cell with exactly three live neighbours becomes a live cell." do
      cell = world.cells.create
      cell.spawn_at(1,1)
      cell.spawn_at(0,1)
      expect(cell.neighbours.count).to eq(2)
      world.tick!

      cell.reload
      world.reload

      expect(world.living_cells.count).to eq(4)
    end
  end
end
