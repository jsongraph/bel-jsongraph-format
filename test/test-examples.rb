require 'json'
require 'json-schema'
require 'minitest/autorun'
require 'minitest/unit'

class ExamplesTest < Minitest::Unit::TestCase

  def setup
    root = File.expand_path('..', __FILE__)
    @schema = JSON.parse(
      File.read(
        File.join(root, '..', 'bel-json-graph.schema.json')
      )
    )
    @examples = Dir[File.join(root, 'examples', '*.json')]
  end

  def test_examples
    @examples.each do |ex|
      data = JSON.parse File.open(ex, 'r:UTF-8', &:read)
      errors = JSON::Validator.fully_validate(@schema, data, :insert_defaults => true)

      if ENV['JGS_VERBOSE']
        puts "\n\nValidated JSON for example: #{ex}"
        pp data
      end

      assert errors.empty?, errors.join("\n")
    end
  end
end
# vim: ts=2 sts=2 sw=2
