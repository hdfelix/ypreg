Thanks for the help, Joe. I really appreciate it. Here's some background about the project followed by my issues.


###  Background
* This is an event registration site for a church youth group ministry. They have several types of events throughout the year and are currently managing registration with Google Docs, which has become quite an unwieldy platform for this type of thing.
* 
* About my skill level - I used to code close to a decade ago and have been mainly doing project management and IT support since. This project has been my 'gateway' back into programming after all these years. I'm fairly new to Rails and this has been my main project to learn Rails, Ruby, BDD, RSpec, Capybara, etc. I've tried to follow BDD, but haven't done so 100% (I need to go back and write some missing tests). B/c of the deadline for this project and having to learn RSpec and Capybara at the same time, I've got some holes in my tests...
* I am using a bootstrap theme for this site called Kingadmin (https://wrapbootstrap.com/theme/kingadmin-responsive-admin-dashboard-WB09JXK43). It currently uses jQuery version 2.1.0, which is not supported by the jquery-rails gem (the gem has versions that support 2.1.1 and 2.1.3).

### The issues
* I had some JS errors on the console, and after moving files around in the application.js manifest, I got all but one JS error fixed. Before that, after pushing files to Heroku, the menus would not open and close. Now they do. I still have one JS error. And after moving things around in the manifest, now my jQuery calendars don't work (e.g., for the date fields on app/views/events/_form.html.erb). This is issue #1 (JS error, calendars not working).
* Secondly, I wasn't sure how to properly handle assets when pushing code up to staging via Continous Deployment (using Codeship currently). I've read through the Rails Guides and used the approach the suggested in the [Precompiling Assets](http://guides.rubyonrails.org/asset_pipeline.html#precompiling-assets) section of the Asset Pipeline rails guide. I think the way I've gotten it to work is actually precompiling beforehand. I've also played with adding a script on `after_success` on CodeShip with:
```
# bundle exec rake assets:precompile
# # test -f ~/.ssh/id_rsa.heroku || ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.heroku &&  heroku keys:add ~/.ssh/id_rsa.heroku
# # git remote -v | grep ^heroku || heroku git:remote --ssh-git --app ypreg-staging
# # git push -f staging master
# # git push -f git@heroku.com:ypreg-staging.git master
# # heroku run rake db:migrate --app ypreg-staging
```
But I'm not confident I'm doing things correctly. Any help along the lines of properly handling asset pipeline on production (or CI to staging) would be very much appreciated.

Thanks!

Hector
