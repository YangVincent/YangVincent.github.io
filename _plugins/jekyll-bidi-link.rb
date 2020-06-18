module JekyllFeed
	class Generator < Jekyll::Generator
		def generate(site)
			backlinks = Hash.new
			counter = 1
			@site = site
			site.collections.each do |cname, meta|
				if cname == "drafts"
					next
				end
				Jekyll.logger.info "Jekyll Feed:", "Generating feed for #{cname}"
				Jekyll.logger.info "Jekyll Meta:", "Generating meta for #{meta}"


				meta.docs.each do |m|
					if m == nil
						next
					end

					#if m.data["title"] != "Test 1" && m.data["title"] != "Test 2"
					#	next
					#end

					###############################
					# Get Filename to store links
					###############################
					if m.data["date"] != nil
						filename = "_" + cname + "/" + m.data["date"].utc.strftime('%Y-%m-%d') + "-" + m.data["slug"] + m.data["ext"]
					else
						filename = "_" + cname + "/" + m.data["slug"] + m.data["ext"]
					end

					
					######################
					# Detect all links
					######################
					lnks = m.content.scan(/post_url.* /)

					# Create links we can link to
					cleanlnks = []

					lnks.each do |lnk|
						# Remove "post_url" and ending space. Use the target URL as the key so we can reverse.
						target = "_posts/" + lnk[9..-2] + ".md"
						if backlinks.has_key?(target)
							backlinks[target].push(filename)
							backlinks[target].uniq! # Remove duplicates
						else
							backlinks[target] = Array[filename]
						end
					end
				end
			end

			###########################
			# Writing out to the page
			###########################
			Jekyll.logger.info "All pages: #{site.pages}"
			site.collections.each do |cname, meta|
				if cname == "drafts"
					next
				end
				# Output our findings!
				meta.docs.each do |m| 
					if m == nil 
						next
					end
					if m.data["date"] != nil
						filename = "_" + cname + "/" + m.data["date"].utc.strftime('%Y-%m-%d') + "-" + m.data["slug"] + m.data["ext"]
						m.data["backlink"] = backlinks[filename]
					else
						filename = "_" + cname + "/" + m.data["slug"] + m.data["ext"]
						m.data["backlink"] = backlinks[filename]
					end
				end
			end
		end

		# Determines the destination path of a given feed
    	#
    	# collection - the name of a collection, e.g., "posts"
    	# category - a category within that collection, e.g., "news"
    	#
    	# Will return "/feed.xml", or the config-specified default feed for posts
    	# Will return `/feed/category.xml` for post categories
    	# WIll return `/feed/collection.xml` for other collections
    	# Will return `/feed/collection/category.xml` for other collection categories
    	def feed_path(collection: "posts", category: nil)
    		prefix = collection == "posts" ? "/feed" : "/feed/#{collection}"
    		return "#{prefix}/#{category}.xml" if category

    		collections.dig(collection, "path") || "#{prefix}.xml"
    	end
	end
end

