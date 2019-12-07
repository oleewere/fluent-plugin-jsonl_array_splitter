gem:
	rm -f fluent-plugin-jsonl_array_splitter*.gem
	gem build fluent-plugin-jsonl_array_splitter.gemspec

install: gem
	gem install fluent-plugin-jsonl_array_splitter*.gem