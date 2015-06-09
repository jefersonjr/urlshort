class ShortcutsController < ApplicationController
  before_action :set_shortcut, only: [:show, :destroy, :redirect]
  before_filter :authenticate_user!

  respond_to :html

  def index
    @shortcuts = Shortcut.where(:user => current_user).order('created_at DESC').paginate(:per_page => 10, :page => params[:page])
  end

  def new
    @shortcut = Shortcut.new
  end

  def create
    @shortcut = Shortcut.create(shortcut_params.merge({ user: current_user, created_at: DateTime.now }))
    respond_with @shortcut
  end

  def show

  end

  def redirect
    redirect_to_full_url(@shortcut)
  end

  private
    def set_shortcut
      @shortcut = Shortcut.find(params[:id])
    end

    def shortcut_params
      params.require(:shortcut).permit(:full_url)
    end

end