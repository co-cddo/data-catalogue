# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Dir.glob(File.join(Rails.root, 'db/seeds/*.json')) do |filename|
  content = File.read(filename)
  JSON.parse(content)['apis'].each do |json|
    organisation = Organisation.find_or_create_by(name: json['data']['organisation'])
    data_service = DataService.find_or_create_by(organisation:, name: json['data']['name'],
                                                 description: json['data']['description'],
                                                 url: json['data']['url'],
                                                 contact: json['data']['contact'],
                                                 documentation_url: json['data']['documentation-url'])
    puts "#{data_service.name} created"
  end
end
