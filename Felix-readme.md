Hi Hector,

I'm always happy to help, sorry it's been so delayed. I think there was a
bit of miscommunication going on!

### What I've found

* The sprockets file wasn't importing the correct files anymore
  * I think it is most probably because you've tried to reorder the
    manifest and have removed the require_tree directive.
  * You can still use "//= require_tree ." after you've imported the
    files you want first, it will pull in the remaining files in
    alphabetic order
* There is a controller named SecretControllerController
  * the duplicate "Contoller" part should be removed
  * generally it's best practice to name rails controllers as plural
    because they are controlling multiple db record, i.e.
    SecretController suggests there can be only one controller. Normally
    you would name it SecretsController, notice the pluralization of
    'Secret'
* The codebase looks overall pretty good but could do with some
  refactoring;
  * from a quick glance it seems as though there are files
  which aren't needed.
  * The gemfile is quite large too, normally I try to
  keep Gemfile as small as possible so it is easier to read

I'm going to leave some comments in github for you on the pull-request.
I've updated heroku so that's working now.

Best wishes
Joe


### Continuous Integration with Codeship

Have you worked through this guide?
(https://devcenter.heroku.com/articles/codeship) It explains it pretty
well, it's actually pretty simple with that guide. You should be able to
easily set it up so that any changes to master on GH are built and
tested on CI and then, once passed, automatically deployed to heroku.
