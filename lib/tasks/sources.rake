# frozen_string_literal: true

namespace :sources do
  desc 'Adds a source to fetch services from'
  task :create, %i[name url] => :environment do |_t, args|
    Sources::CreateService.call(name: args[:name], url: args[:url])
  end
end
