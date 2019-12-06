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
                    record[@key_name].each do |r|
                        new_record = record.clone
                        new_record.update(r)

                        if !@reserve_key then
                            new_record.delete(@key_name)
                        end
                        new_es.add(time, new_record)
                    end
                end
                new_es
            end

            def jsonl_generate(objs, opts = nil)
                unless objs.is_a?(Array)
                    raise TypeError, "can't generate from #{objs.class}"
                end
                generated = []
                objs.map do |obj|
                  generated << JSON.generate(obj, opts)
                end
                generated.join("\n")
            end

            def jsonl_parse(source, opts = {})
                parsed = []
                source.each_line do |line|
                    parsed << JSON.parse(line, opts)
                end
                parsed
            end
        end
    end
end
    