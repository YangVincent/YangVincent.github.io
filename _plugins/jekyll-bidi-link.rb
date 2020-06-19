module JekyllFeed
	class Generator < Jekyll::Generator
        def levenshtein_distance(s, t)
			return 1000 if s == nil || t == nil
  			m = s.length
  			n = t.length
  			return m if n == 0
  			return n if m == 0
  			d = Array.new(m+1) {Array.new(n+1)}

  			(0..m).each {|i| d[i][0] = i}
  			(0..n).each {|j| d[0][j] = j}
  			(1..n).each do |j|
  			  (1..m).each do |i|
  			    d[i][j] = if s[i-1] == t[j-1]  # adjust index into string
  			                d[i-1][j-1]       # no operation required
  			              else
  			                [ d[i-1][j]+1,    # deletion
  			                  d[i][j-1]+1,    # insertion
  			                  d[i-1][j-1]+1,  # substitution
  			                ].min
  			              end
  			  end
  			end
  			d[m][n]
		end


		def generate(site)
			backlinks = Hash.new
			@site = site

			###
			# Get all posts
			###
			allpages = []
			site.collections.each do |cname, meta|
				meta.docs.each do |m|
					filename = "_" + cname + "/" + m.data["date"].utc.strftime('%Y-%m-%d') + "-" + m.data["slug"] + m.data["ext"]
					allpages.push(filename)
				end
			end


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

					Jekyll.logger.info "Currently finding links coming from ", "#{m.data["slug"]}"

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
					# Look for bidi, then some whitespace, then 0+ [non-whitespace + whitespace]
					blnks = m.content.scan(/bidi\s[[\w]+[\s]]+/)
					# String match to find the most similar one
					blnks.each do |blnk|
						Jekyll.logger.info "Checking link: #{blnk}"
						min_dist = 1000
						target = ""
						allpages.each do |page|
							l_dist = levenshtein_distance(page[/\-[a-z]*.*\./][7..-2].downcase.gsub(" ", "-").gsub(",", ""), blnk[5..-1].downcase.gsub(" ", "-").gsub(",", ""))
							if l_dist < min_dist
								target = page
								min_dist = l_dist
							end
						end

                        if target != nil && min_dist <= 1
							Jekyll.logger.info "Adding link from #{target} to #{filename}"
							if backlinks.has_key?(target)
								backlinks[target].push(filename)
								backlinks[target].uniq! # Remove duplicates
							else
								backlinks[target] = Array[filename]
							end
						end

					end
				end
			end

			###########################
			# Writing out to the page
			###########################
			#Jekyll.logger.info "All pages: #{site.pages}"
			site.collections.each do |cname, meta|
				if cname == "drafts"
					next
				end
				# Output our findings!
				meta.docs.each do |m| 
					if m == nil 
						next
					end
					#Jekyll.logger.info "Meta.docs.each m is ", "#{m.data}"
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

