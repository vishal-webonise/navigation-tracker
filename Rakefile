#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

NavigationTracker::Application.load_tasks

# rake app:add_admin_user
desc 'Add Admin user'
namespace :app do
    task :add_admin_user => :environment do
      user = User.create!(name: 'Admin', email: 'admin@weboniselab.com', login_type: 'admin', password: '123456')
      user.save
    end
end