# frozen_string_literal: true

require 'open3'
require 'tempfile'

class JsonValidator < BaseService
  class ValidationError < StandardError; end

  def initialize(json:, schema_path:)
    @json = json
    @schema_path = schema_path
  end

  def call
    Open3.capture2(command)
  ensure
    File.unlink(@json_file)
  end

  private

  def json_file
    @json_file ||= Tempfile.create
    @json_file.write(@json)
    @json_file
  end

  def command
    "check-jsonschema -v --schemafile #{@schema_path} #{json_file.path}"
  end
end
