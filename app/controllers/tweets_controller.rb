class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    #ログイン中にしたツイートリンクが表示されないのでsession[:user_id]が空であることは考慮しなくてよい
    logger.debug "---------------"
    user = User.find_by(uid: current_user.uid)
    @tweet = Tweet.new(message: params[:tweet][:message], user_id: user.id)
    if @tweet.save
      #TODO: ツイートが成功したことをユーザに知らせる
      flash[:notice] = 'ツイート完了'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    if tweet.destroy
      flash[:notice] = 'ツイートを削除しました'
    end
    redirect_to root_path
  end
end
