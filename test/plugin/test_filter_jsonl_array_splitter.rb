require 'bundler/setup'
require 'test/unit'
require 'fluent/log'
require 'fluent/test'
require 'fluent/test/driver/filter'
require 'fluent/plugin/filter_jsonl_array_splitter'

class RubyFilterTest < Test::Unit::TestCase
  include Fluent

  setup do
    Fluent::Test.setup
  end

  def emit(msg, conf='')
    d = Test::Driver::Filter.new(Plugin::JsonlArraySplitterFilter).configure(conf)
    d.run(default_tag: 'test') {
      d.feed(msg)
    }
    d.filtered
  end

  sub_test_case 'filter' do
    test 'execute to jsonl array' do
      msg = {'a' => 'b', 'c' => '{\"d\": \"e\", \"f\": \"g\"}\n{\"d\": \"h\", \"f\": \"i\"}'}
      es  = emit(msg)
      assert_equal(msg.count, es.count)
      es.each_with_index do |e, i|
        assert_equal(msg[i], e[0])
      end
    end
  end
end