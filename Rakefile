#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'rake/testtask'
require File.expand_path('../src/server', __FILE__)

task :default do
  ENV['RACK_ENV'] = 'test'
  Rake::Task['test'].invoke
end

Rake::TestTask.new(:default) do |t|
  t.libs << "test"
  t.pattern = 'test/*_spec.rb'
  t.verbose = true
end