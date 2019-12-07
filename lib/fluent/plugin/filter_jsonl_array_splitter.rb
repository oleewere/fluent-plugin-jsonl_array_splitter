require 'json'

module Fluent
    module Plugin
        class JsonlArraySplitterFilter < Fluent::Plugin::Filter
            Fluent::Plugin.register_filter("jsonl_array_splitter", self)
      
            desc "Key name that contains JSONL formatted text"
            config_param :key_name, :string
            desc "Keep original key in parsed result."
            config_param :reserve_key, :bool, default: false
            desc 'Enable debug log. Default: false.'
            config_param :debug, :bool, :default => false

            def filter_stream(tag, es)
                new_es = Fluent::MultiEventStream.new
                es.each do |time, record|
                    record_lines = record[@key_name].to_s
                    parsed = []
                    record_lines.each_line do |line|
                        if @debug then
                            log.debug("Read JSON line: #{line}")
                        end
                        parsed << JSON.parse("#{line}")
                    end

                    parsed.each do |r|
                        new_record = record.clone
                        new_record.update(r)

                        if !@reserve_key then
                            new_record.delete(@key_name)
                        end
                        if @debug then
                            log.debug("New record by json line filter: #{new_record}")
                        end
                        new_es.add(time, new_record)
                    end
                end
                new_es
            end
        end
    end
end
    