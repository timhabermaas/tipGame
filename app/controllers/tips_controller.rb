class TipsController < ApplicationController

  before_filter :login_required, :except => [:index]

  def index
    @matches = Match.started.recent.includes(:team_1, :team_2).reverse
    @users = User.scoped
    @tips = Tip.includes(:match, :user)
  end

#TODO: check the order. there must be a mistake!
  def show
    @preliminaries = Match.preliminary.group_by { |m| m.group.to_s }.sort_by { |group, m| group }
    @finals = Match.final.group_by { |m| m.round }
    @tips = current_user.tips
    @user = current_user
  end

#TODO: check the order. there must be a mistake!
  def edit
    @user = current_user
    Match.all.each do |match|
      logger.info "''''''''''''''''''''''''inlcude match? #{@user.tips.select{ |t| t.match_id == match.id }.empty?}"
      @user.tips.build :match => match if @user.tips.select{ |t| t.match_id == match.id }.empty?
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Deine Tipps wurden gespeichert"
      redirect_to tips_path
    else
      render :edit
    end
  end

end
