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
    service = DataServices::Creator.call(name: json['data']['name'],
                                         url: json['data']['url'],
                                         organisation_name: json['data']['organisation'],
                                         optional: {
                                           description: json['data']['description'],
                                           documentation_url: json['data']['documentation-url']})
    
        Rails.logger.debug { "#{service.name} created" }
  end
end
