class ApiController < ActionController::API
	
	before_action :cors_preflight_check
  before_action :cors_set_access_control_headers

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers, Authorization'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers, Authorization'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  private

  def response_data(data, message, status, error: nil, disabled: false, update: false, params: {})
    result = Hash.new
    result[:data] = data
    result[:message] = message
    result[:status] = status
    result[:error] = error
    result[:disabled] = disabled
    result[:update] = update
    render json: result, params: params, status: status
  end
  
end
