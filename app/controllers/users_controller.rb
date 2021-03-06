#encoding: utf-8

class UsersController < ApplicationController

  before_filter :login_required, :except => [:new, :create, :index]

  def index
    @users = User.includes(:tips => :match).sort_by(&:points).reverse
  end

  def show
    @user = User.find params[:id]
    unauthorized! unless current_user == @user or current_user.admin?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]

    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      current_user = @user
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
    @user = User.find params[:id]
    unauthorized! unless current_user == @user or current_user.admin?
  end

  def update
    @user = User.find params[:id]
    unauthorized! unless current_user == @user or current_user.admin?

    if @user.update_attributes params[:user]
      flash[:notice] = "Deine Änderungen wurden gespeichert"
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end
end
