module Fluent
    module Plugin
        class JsonlArraySplitterFilter < Fluent::Plugin::Filter
            Fluent::Plugin.register_filter("jsonl_array_splitter", self)
      
            desc "Key name that contains JSONL formatted text"
            config_param :key_name, :string
            desc "Keep original key in parsed result."
            config_param :reserve_key, :bool, default: false
            

        end
    end
end
    