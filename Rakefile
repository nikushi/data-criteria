require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

#  Benchmark
#-----------------------------------------------
desc "Compare with pure ruby and rubype"
task :benchmark do
  require "benchmark/ips"
  require "data-criteria"
  require "data/criteria/version"

  puts "ruby version: #{RUBY_VERSION}"
  puts "data-criteria version: #{Data::Criteria::VERSION}"

  users = [
    {
      id: 1,
      name: "Takeshi",
      city: 'Kagawa',
      age: 33,
      money: 100_000,
    },
    {
      id: 2,
      name: "Ryota",
      city: 'Hiroshima',
      age: 18,
      money: 500,
    },
    {
      id: 3,
      name: "Masanori",
      city: 'Hokkaido',
      age: 14,
      money: 30,
    },
  ]

  criteria = Data::Criteria.new(
    name: /ta/i,
    city: %w(Kagawa Hiroshima),
    age: 0..20,
    money: '>= 300',
  )

  filter = proc {|user|
    user[:name] =~ /ta/i &&
      %w(Kagawa Hiroshima).include?(user[:city]) &&
      (0..20).include?(user[:age]) &&
      user[:money] >= 300
  }

  Benchmark.ips do |x|
    x.report('data-criteria') { users.select{|user| criteria.match_all?(user) } }
    x.report('normal block')  { users.select(&filter) }

    x.compare!
  end
end
task bm: :benchmark
