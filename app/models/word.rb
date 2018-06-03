class Word < ActiveRecord::Base

	def self.get_words(query_string,query_length,query_method)
		# Finding Words with chars in query string
		return nil if query_string.nil?
		query_string = query_string.chars.sort.join
		sorted_seq = get_subsequences(query_string, query_string.length)
		candidate_sorted_seq = []
		if query_length.nil? || query_length.empty? 
			candidate_sorted_seq << query_string # for case if query_length parameter is not given, then consider complete query string
		elsif query_length.to_i > 0
			sorted_seq.each do |item| 
				if query_method == "e" || query_method.nil? || query_method.empty?
					candidate_sorted_seq << item if (item.length == query_length.to_i)
				elsif query_method == "lte"
					candidate_sorted_seq << item if (item.length <= query_length.to_i)
				elsif query_method == "lt"
					candidate_sorted_seq << item if (item.length < query_length.to_i)
				end
			end		
		end
		candidate_sorted_words = self.where("sorted in (?)", candidate_sorted_seq.to_set.to_a).pluck(:text) # benefit is that we need not check permutation of each sub-sequence of query string
		return candidate_sorted_words
	end

	private 

	# Recursive function
	def self.get_subsequences(query_string, length)
		return [""] if length == 0 || query_string.nil? || query_string.empty?

		string_len = query_string.length
		# considering we included 1st char
		sub_sol1 = get_subsequences(query_string.slice(1..string_len),length-1)
		for i in 0..sub_sol1.length-1
			sub_sol1[i] = query_string[0] + sub_sol1[i]
		end

		# considering 1st char wasn't included
		sub_sol2 = get_subsequences(query_string.slice(1..string_len),length)
		return sub_sol1 + sub_sol2
	end


end
