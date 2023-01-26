# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_126_124_846) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'data_services', force: :cascade do |t|
    t.text 'name', null: false
    t.text 'description'
    t.text 'url'
    t.text 'contact'
    t.text 'documentation_url'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'organisation_id'
    t.index ['organisation_id'], name: 'index_data_services_on_organisation_id'
  end

  create_table 'organisations', force: :cascade do |t|
    t.text 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
