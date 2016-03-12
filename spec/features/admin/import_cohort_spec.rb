# Feature: 'Admin Dashboard' page
#   As an admin
#   I want to visit an 'admin dashboard' page
#   So I can take various admin-y actions

feature 'Admin Dashboard Page' do

  # Scenario: Visit the 'admin dashboard' page
  #   Given I am an admin
  #   When I visit the '/admin' page
  #   Then I see "Admin Dashboard"
  scenario 'Visit the admin page' do
    visit '/admin'
    expect(page).to have_content 'Admin Dashboard'
  end

end
