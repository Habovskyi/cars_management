# How to setup my application

### Step by step
1. You must have Ruby installed (according to the file .ruby-version)
2. Perform the operation of adding a remote repository git clone [cars_management](https://github.com/Habovskyi/cars_management.git)
3. Change the working directory to the project directory`cd cars_management`
4. Run in terminal `bundle install` for install dependencies
5. Run the project for execution in terminal `irb index.rb`

### Rake command
`rake -T` - a command to view rake tasks and describe them.
The program contains two rake commands:
1. `rake car_database:clear` - responsible for cleaning the car database.
2. `rake car_database:add_record[quantity]` - is responsible for adding cars to the database, the parameter can specify the number of cars to be added, 1 car is added by default.

### Note
[Car database](https://gist.github.com/Svatok/bd80ffb7d34969262e5a65579e3a0d86)
