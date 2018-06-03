namespace :update_dictionary do
	
	desc "Updates Dictionary With Words in 'words' file in root folder of APP"

	# Words added will be small case only
  # https://github.com/first20hours/google-10000-english/edit/master/google-10000-english.txt this file is used
	task :update => :environment do
  	data = File.read("words").split("\n")
  	data.each do |word|
  		sorted_char_set = word.downcase.chars.sort.join
  		Word.create(text: word.downcase, sorted: sorted_char_set)
  	end
  end

end
