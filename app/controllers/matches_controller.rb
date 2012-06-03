#encoding: utf-8

class MatchesController < ApplicationController

  before_filter :admin_required, :except => [ :index, :show ]

  def index
    @preliminaries = Match.preliminary.group_by { |m| m.group.to_s }.sort_by { |group, m| group }
    @finals = Match.final.group_by { |m| m.round }
  end

  def new
    @match = Match.new
  end

  def create
    @match = Match.new params[:match]

    if @match.save
      flash[:notice] = "Spiel wurde erfolgreich erstellt"
      redirect_to new_match_path
    else
      render :new
    end
  end

  def edit
    @match = Match.find params[:id]
  end

  def update
    @match = Match.find params[:id]

    if @match.update_attributes params[:match]
      flash[:notice] = "Spiel wurde erfolgreich geändert"
      redirect_to matches_path
    else
      render :edit
    end
  end
end
