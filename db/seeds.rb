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

user = User.create! name: "Chris McCord",
                    email: "user@example.com",
                    password: 'password',
                    password_confirmation: 'password'


["Labrador", "Sync", "gitit"].each do |project_name|
  project = user.projects.create! name: project_name
  [
    "Add batch sending of messages from rails app to faye server.",
    "Split into lib files and add faye authentication.",
    "Add ability to sync new record creation.",
    "Refactor scripts out to javascript object.",
    "Pull out prototypes into classes.",
    "Remove deprecated code.",
    "Remove redundant modal assignment.",
    "Refactor application controller to use NullApp and clean up runtime error handling.",
    "Add helper method for current database.",
    "Add NullApp to prevent nil checks and update unit tests.",
    "Merge pull request #21 from jdanbrown/patch-1",
    "Upgrade to rails 3.2.12 to addresss security vulnerabilities.",
    "Labrador::App.initialize: Default @path to @name",
    "Refactor DataController to better control parameter evaluation.",
    "Fix RethinkDB#update failing when passed HashWithIndifferentAccess.",
    "Add AdapterError class and clean up application controller.",
    "Use getter methods instead of instance variables.",
    "Add App unit tests for connect methods.",
    "Add rethinkdb title to new connection header.",
    "Add rethinkdb support.",
    "Upgrade to Rails 3.2.11 to address security vulnerability",
    "Merge pull request #18 from exploid/patch-1",
    "Fix typo in unauthorized error message.",
    "Set default host on new connection form.",
    "Precompile assets for release.",
    "Internationalize manual connection markup.",
    "Add Labrador::VERSION",
    "Add unit test coverage for Session functionality.",
    "Update tests to fix hanging connections issue."
  ].each{|task| project.todos.create! title: task }
end

