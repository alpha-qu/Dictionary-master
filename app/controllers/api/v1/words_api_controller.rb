module Api
  module V1
  	class WordsApiController < ::ApiController

  		def query
        query_string = params[:query_string]
				query_length = params[:query_length]
				query_method = params[:query_method]
				data = Word.get_words(query_string,query_length,query_method)
				response_data data, "Successfully executed query", 200
  		end

  	end
  end
end