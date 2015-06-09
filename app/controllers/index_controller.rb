class IndexController < ApplicationController
  def index
    # Load five last shortcuts from current user
    if current_user.present?
      @lasts_shortcuts = Shortcut.where(:user => current_user).limit(5).order('created_at DESC')
    end
  end

  # parse a shortcut from unknown route
  def parse_shortcut
    # Try to load shortcut, log access and redirect user
    shortcut_list = Shortcut.where(:short_url => request[:path])

    if shortcut_list.count > 0
      # Yeah, shortcut exists
      redirect_to_full_url(shortcut_list.first)
    else
      render :shortcut_not_found
    end

    # About page
    def about

    end
  end
end
