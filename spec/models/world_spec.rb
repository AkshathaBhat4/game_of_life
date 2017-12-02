require 'rails_helper'

RSpec.describe World, type: :model do
  context 'cell utility methods' do
    subject { World.create()}

    it 'world default state' do
      expect(subject.generation_count).to eq 0
      expect(subject.top_x).to eq 0
      expect(subject.top_y).to eq 0
      expect(subject.bottom_x).to eq 0
      expect(subject.bottom_y).to eq 0
    end

    it 'update world co-ordinates' do
      subject.update_coordinates_for(2,1)
      expect(subject.top_x).to eq 3
      expect(subject.top_y).to eq 2
      expect(subject.bottom_x).to eq 0
      expect(subject.bottom_y).to eq 0

      subject.update_coordinates_for(-2,-2)
      expect(subject.top_x).to eq 3
      expect(subject.top_y).to eq 2
      expect(subject.bottom_x).to eq -3
      expect(subject.bottom_y).to eq -3
    end

    it 'find live cell co-ordinates' do
      expect(subject.find_live_cell_coordinates).to be_empty
      subject.cells.create(x: 5, y: 3)
      subject.reload
      expect(subject.find_live_cell_coordinates).to have_key('5')
      expect(subject.find_live_cell_coordinates['5']).to have_key('3')
      expect(subject.find_live_cell_coordinates['5']['3']).to be true
    end

  end

end
