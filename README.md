# Video Games Library

Welcome to *Video Games Library*, a Sinatra Web App where you can create and manage your video game collection! 

In Video Games Library, a user can:
 - create a secure account
 - securly log in
 - create, read, edit, and delete game titles

 A user cannot:
 - edit or delete other users' entries
 - see or interact with the library when logged out
 - Cannot log in with out registration 

## Installation

 From your terminal, you can clone and install this app by running:` https://github.com/SilverBright/video-games-library-sinatra-project `

Change directory to `video-games-library`, and run the following:

```ruby
bundle install
rake db:migrate
shotgun
```

##Instructions

Create a new account, then log in.  
You will be taken to the main index page where you can see a list of all users' video game submissions.
Select 'Add a game' to add your game title and platform, then click 'submit.
From here, you can edit or delete your entry, add a new game, or view the library.
To edit or delete your title from the Library, simply click on the title which will take you directly to the edit screen. 


## Specs

- App built using Sinatra
- Includes ActiveRecord for storing information in a database
- Create user accounts with account registration and login / logout capability
- Users cannot modify content created by other users
- Contains CRUD operations and MVC component structure, and RESTful routes
- Includes Navbar for quick and easy navigation
- Implements Bootstrap for simple, responsive styling

## Contributing

Bug reports and pull requests are welcome on GitHub.  This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The app is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Credits

Bootstrap references were obtained from [here](https://getbootstrap.com)

Project structure developed with Corneal gem.
