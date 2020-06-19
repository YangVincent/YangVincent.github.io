# frozen_string_literal: true

module Jekyll
    module Tags
        class PostComparer
            MATCHER = %r!^(.+/)*(\d+-\d+-\d+)-(.*)$!.freeze
            MATCHER = %r!^(.+/)*(.*)$!.freeze

            attr_reader :path, :date, :slug, :name

            def initialize(name)
                @name = name

                all, @path, @date, @slug = *name.sub(%r!^/!, "").match(MATCHER)

                Jekyll.logger.info "all is ", "#{all}"
                Jekyll.logger.info "path is ", "#{@path}"
                Jekyll.logger.info "date is ", "#{@date}"
                Jekyll.logger.info "slug is ", "#{@slug}"
                unless all
                  raise Jekyll::Errors::InvalidPostNameError,
                        "'#{name}' does not contain valid date and/or title."
                end

                escaped_slug = Regexp.escape(slug)
                @name_regex = %r!^_posts/#{path}#{date}-#{escaped_slug}\.[^.]+|
                  ^#{path}_posts/?#{date}-#{escaped_slug}\.[^.]+!x
            end

            def post_date
                @post_date ||= Utils.parse_date(
                  date,
                  "'#{date}' does not contain valid date and/or title."
                )
            end

            def ==(other)
                other.relative_path.match(@name_regex)
            end

            def deprecated_equality(other)
                slug == post_slug(other) &&
                  post_date.year  == other.date.year &&
                  post_date.month == other.date.month &&
                  post_date.day   == other.date.day
            end

            private

            # Construct the directory-aware post slug for a Jekyll::Post
            #
            # other - the Jekyll::Post
            #
            # Returns the post slug with the subdirectory (relative to _posts)
            def post_slug(other)
                path = other.basename.split("/")[0...-1].join("/")
                if path.nil? || path == ""
                    other.data["slug"]
                else
                    path + "/" + other.data["slug"]
                end
            end
        end

        class PostUrl < Liquid::Tag
            include Jekyll::Filters::URLFilters

                # For each tag...
                def initialize(tag_name, post, tokens)
                    super
                    @orig_post = post.strip
                end

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

                def render(context)
                    @context = context
                    @backlinks = Hash.new
                    site = context.registers[:site]

                    ###
                    # Use distance to find similar post.
                    ###
                    ###
                    # Get all posts
                    ###
                    allpages = []
                    allpagehash = Hash.new
                    site.collections.each do |cname, meta|
                    	if cname == "drafts"
                    		next
                    	end
                    	meta.docs.each do |m|
                    		filename = "_" + cname + "/" + m.data["date"].utc.strftime('%Y-%m-%d') + "-" + m.data["slug"] + m.data["ext"]
                    		allpages.push(filename)
                            allpagehash[filename] = m
                    	end
                    end

                    site.collections.each do |cname, meta|
                    	if cname == "drafts"
                    		next
                    	end
                    	meta.docs.each do |m|
                    		if m == nil
                    			next
                    		end

                    		###############################
                    		# Get Filename to store links
                    		###############################
                    		if m.data["date"] != nil
                    			filename = "_" + cname + "/" + m.data["date"].utc.strftime('%Y-%m-%d') + "-" + m.data["slug"] + m.data["ext"]
                    		else
                    			filename = "_" + cname + "/" + m.data["slug"] + m.data["ext"]
                    		end

                            ########
                            # Look for target of current post
                            ########
                    		min_dist = 1000
                            target_doc = nil
                    		allpages.each do |page|
                                @post = @orig_post
                                l_dist = levenshtein_distance(page[/\-[a-z]*.*\./][7..-2].downcase.gsub(" ", "-"), @post.gsub(" ", "-"))
                    			if l_dist < min_dist
                    				min_dist = l_dist
                                    target_doc = page
                    			end
                    		end
                            if target_doc != nil && min_dist <= 1
                                return relative_url(allpagehash[target_doc])
                            else
                                raise Jekyll::Errors::PostURLError, <<~MSG
                                  Could not find post "#{@orig_post}" in tag 'bidi'.
                                  Make sure the post exists and the name is correct.
                                MSG
                                Jekyll::Deprecator.deprecation_message "A call to "\
                                  "'{% bidi #{@post.name} %}' did not match " \
                                  "a post using the new matching method of checking name " \
                                  "(path-date-slug) equality. Please make sure that you " \
                                  "change this tag to match the post's name exactly."
                            end
                        end
                    end
                end
        end
    end
end

Liquid::Template.register_tag("bidi", Jekyll::Tags::PostUrl)
