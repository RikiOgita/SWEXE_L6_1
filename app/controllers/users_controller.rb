class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    logger.debug "---------------"
    @user = User.new(uid: params[:user][:uid],
    password: params[:user][:password],
    password_confirmation: params[:user][:password_confirmation])
    if @user.valid? #validatesを実行してくれる
      #TODO:成功したことを
      flash[:notice] = 'ユーザ登録完了'
      @user.pass = BCrypt::Password.create(params[:user][:password])
      @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      flash[:notice] = 'ユーザを削除しました'
    end
    redirect_to users_path
  end
end
