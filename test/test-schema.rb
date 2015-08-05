require 'json'
require 'json-schema'
require "minitest/autorun"
require "minitest/unit"

class SchemaTest < Minitest::Unit::TestCase

  def test_validate_schema
    schema = File.read(
      File.join(
        File.expand_path('..', File.dirname(__FILE__)),
        'bel-json-graph.schema.json'
      )
    )
    errors = JSON::Validator.fully_validate_schema(schema)

    assert errors.empty?, errors.join("\n")
  end
end
# vim: ts=2 sts=2 sw=2
