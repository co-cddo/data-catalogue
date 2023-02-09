# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Rails.root.glob('db/seeds/*.json') do |filename|
  content = File.read(filename)
  random_string = ('0'..'z').to_a.shuffle.first(8).join
  source_url = "https://localhost/#{random_string}"
  JSON.parse(content)['apis'].each do |json|
    source = Sources::CreateService.call(name: json['data']['organisation'], 
                                         url: source_url,
                                         organisation_name: json['data']['organisation'])
    data_service = DataService.find_or_create_by(source:,
                                                 name: json['data']['name'],
                                                 description: json['data']['description'],
                                                 url: json['data']['url'],
                                                 contact: json['data']['contact'],
                                                 documentation_url: json['data']['documentation-url'])
    Rails.logger.debug { "#{data_service.name} created" }
  end
end
