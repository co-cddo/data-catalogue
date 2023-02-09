namespace :sources do
  desc 'Adds a source to fetch services from'
  task :create, [:name, :url, :organisation_name] => :environment do |_t, args|
    Sources::CreateService.call(name: args[:name],
                                url: args[:url],
                                organisation_name: args[:organisation_name])
  end
end