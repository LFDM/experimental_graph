require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'neography/tasks'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :neo4j do
  desc 'Dump graph db data to a cql file'
  task :dump do
    system('./neo4j/bin/neo4j-shell -c "dump" > ./data/dump.cql')
    puts 'Dump successful! Find the Cypher file in data/dump.cql'
  end

  desc 'Resets and reseeds the database'
  task :reseed do
    print "Do you really want to continue? Undumped changes will be lost. [y] "
    if $stdin.get.chomp == 'y'
      puts 'Resetting...'
      Rake::Task['neo4j:reset_yes_i_am_sure'].execute
      puts 'Seeding!'
      system('cat ./data/dump.cql | ./neo4j/bin/neo4j-shell')
      puts
      puts 'Seed successful!'
    else
      puts 'Aborted!'
    end
  end
end
