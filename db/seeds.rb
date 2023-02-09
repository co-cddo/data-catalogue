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
  JSON.parse(content)['apis'].each do |json|
    organisation = Organisation.find_or_create_by(name: json['data']['organisation'])
    random_string = ('0'..'z').to_a.shuffle.first(8).join
    source = Source.find_or_create_by(name: json['data']['organisation'], organisation:) do |source|
      source.url = "http://localhost/#{random_string}"
    end
    data_service = DataService.find_or_create_by(source:,
                                                 name: json['data']['name'],
                                                 description: json['data']['description'],
                                                 url: json['data']['url'],
                                                 contact: json['data']['contact'],
                                                 documentation_url: json['data']['documentation-url'])
    Rails.logger.debug { "#{data_service.name} created" }
  end
end
