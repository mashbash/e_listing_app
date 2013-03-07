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
  @user = User.new(access_token: access_token.token, access_token_secret: access_token.secret)
  @user.save 
  redirect '/home'
  # raise access_token.inspect
  # access_token.token and access_token.secret can now be saved for future API calls

end

get '/home' do
  erb :home
end

post '/search' do
  @searchterm = params[:searchterm]
  @listing = Etsy.user(@searchterm)
  raise @listing.inspect
end  
