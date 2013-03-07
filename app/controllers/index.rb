enable :sessions

get '/' do
  request_token = Etsy.request_token
  session[:request_token]  = request_token.token
  session[:request_secret] = request_token.secret
  redirect Etsy.verification_url
end

get '/authorize' do
  access_token = Etsy.access_token(
    session[:request_token],
    session[:request_secret],
    params[:oauth_verifier]
  )

  raise access_token.inspect
  # access_token.token and access_token.secret can now be saved for future API calls

end
