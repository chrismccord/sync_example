# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Project.delete_all
Todo.delete_all

users = []

users[0] = User.create! name: "Chris McCord",
                        email: "user@example.com",
                        password: 'password',
                        password_confirmation: 'password'

users[1] = User.create! name: "Homer Simpson",
                        email: "homer@example.com",
                        password: 'password',
                        password_confirmation: 'password'

["Labrador", "Sync"].each do |project_name|
  project = users[0].projects.create! name: project_name
  [
    "Add ability to sync new record creation.",
    "Pull out prototypes into classes.",
    "Remove deprecated code.",
    "Add rethinkdb support.",
  ].each{|task| project.todos.create! title: task, user: users[rand(users.size)] }
end

