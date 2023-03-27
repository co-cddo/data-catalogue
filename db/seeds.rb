# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

content = Rails.root.join('db/seeds.json').read
JSON.parse(content)['data_services'].each do |json|
  service = DataServiceForm.new(json)

  Rails.logger.debug { "#{service.title} created" } if service.submit
end
