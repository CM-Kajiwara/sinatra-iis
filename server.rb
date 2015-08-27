require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?
set :public_folder, File.dirname(__FILE__) + '/static'

configure :production do
  # set :server, :puma
end

get '/' do
  erb :index
end

# アップロード処理
post '/upload' do
  if params[:file] && params[:execution]
    if params[:execution].to_s =="true" 
      save_path = "./executionStored/#{params[:file][:filename]}"
    elsif  params[:execution].to_s == "false"
      save_path = "./nonExecutionStoreed/#{params[:file][:filename]}"
    end
    p save_path

    File.open(save_path, 'wb') do |f|
      p params[:file][:tempfile]
      f.write params[:file][:tempfile].read
      @mes = "アップロード成功"
    end
  else
    @mes = "アップロード失敗"
  end
end

