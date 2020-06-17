# Outputs the reading time

# Read this in “about 4 minutes”
# Put into your _plugins dir in your Jekyll site
# Usage: Read this in about {{ page.content | reading_time }}
#
# This works
#
#module Jekyll
#	class BidirectionalLinks < Liquid::Tag
#		def initialize(tagName, text, tokens)
#			super
#			@text = text
#			@tokens = tokens
#		end
#
#		def render(context)
#			current_post_url = context.registers[:page]["path"]
#		end
#	end
#end
#Liquid::Template.register_tag('bidili', Jekyll::BidirectionalLinks)
#
# Other useful functions:
# context.registers[:site].collections is a KV map of all collections to their contents.

module Jekyll
	class BidirectionalLinks < Liquid::Tag
		def initialize(tagName, text, tokens)
			super
			@text = text
			@tokens = tokens
		end

		def render(context)
			#for page in context.registers[:site].posts.docs do
			#	puts page.url
			#end
			#puts context.registers[:site].collections.keys[2]
			#
			cls = context.registers[:site].collections
			cls
			#cls["posts"].docs.each{ |key| puts "k: #{key.url}" }

			#for c in cls.each_key do
			#	puts c
			#end
			
			#for collection in context.registers[:site].collections.each_key do 
			#	puts "The hash key is #{collection} and the value is"
			#end

		#	puts context.registers[:site].categories.each_key do |category|
			
			
			#for collection in context.registers[:site].collections do
			#	for page in collection[0] do
			#		puts page
			#	end
			#	#for page in collection do
			#	#	puts page.url
			#	#end
			#end
		end
	end
end
Liquid::Template.register_tag('bidili', Jekyll::BidirectionalLinks)


# Source: https://github.com/benbalter/jekyll-relative-links/blob/master/lib/jekyll-relative-links/generator.rb
#module JekyllBidirectionalLinks
#	class Generator < Jekyll:Generator
#		attr_accessor :site, :config
#
#		# Use Jekyll's native relative_url filter
#		include Jekyll::Filters::URLFilters
#
#		def initialize(config)
#			@config = config
#		end
#
#		def generate(site)
#			return if disabled?
#
#			@site = site
#			@context = context
#
#			documents = site.pages
#		end
#	end
#end

require "jekyll"

module JekyllBidirectionalLinks
end

