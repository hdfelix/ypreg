def show_page
  save_page Rails.public_path.join('capybara.html')
  `launchy 'http://localhost:3000/capybara.html'`
end
