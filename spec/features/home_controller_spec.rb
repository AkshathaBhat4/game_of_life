require 'rails_helper'

RSpec.describe HomeController, type: :feature do
  before :each do
    visit '/'
  end

  it 'launch game of life application', :js => true do
    expect(page).to have_content 'Game Of Life'
  end

  it 'start the game without selecting pattern', :js => true do
    accept_alert do
      click_link 'Start'
    end
  end

  it 'start the game with selecting pattern', :js => true do
    expect(find('#generation_count').value).to have_content(0)

    pattern = Pattern.first.name.titleize
    expect(page).to have_content pattern
    click_link pattern
    click_link 'Start'
    expect(find('#generation_count').value).to have_content(1)
    sleep(1)
    expect(find('#generation_count').value).to have_content(2)
  end


  it 'stop the game', :js => true do
    expect(find('#generation_count').value).to have_content(0)

    pattern = Pattern.first.name.titleize
    expect(page).to have_content pattern
    click_link pattern
    click_link 'Start'
    expect(find('#generation_count').value).to have_content(1)
    sleep(1)
    expect(find('#generation_count').value).to have_content(2)
    click_link 'Stop'
    sleep(2)
    expect(find('#generation_count').value).to have_content(2)
  end

  it 'games next generation', :js => true do
    expect(find('#generation_count').value).to have_content(0)

    pattern = Pattern.first.name.titleize
    expect(page).to have_content pattern
    click_link pattern
    click_link 'Next Generation'
    expect(find('#generation_count').value).to have_content(1)
    sleep(2)
    expect(find('#generation_count').value).to have_content(1)
    click_link 'Next Generation'
    expect(find('#generation_count').value).to have_content(2)
  end

end
