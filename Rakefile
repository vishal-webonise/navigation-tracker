#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

NavigationTracker::Application.load_tasks

# rake app:create_admin_user
desc 'Create Admin user'
namespace :app do
    task :create_admin_user => :environment do
      user = User.create!(first_name: 'Super', last_name: 'Admin', email: 'admin@analytics.com', login_type: 'admin', password: 'analytics2012', password_confirmation: 'analytics2012')
      user.save
    end
end
