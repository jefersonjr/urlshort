class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Redirect shortcut to full URL
  def redirect_to_full_url(shortcut)
    # Log shortcut access
    access = ShortcutAccess.create(shortcut: shortcut, access_date: DateTime.now, access_ip: request.remote_ip)

    # Increment shortcut hit
    shortcut.hits += 1
    shortcut.save

    # Redirect
    if shortcut.full_url.starts_with?('http')
      redirect_to shortcut.full_url
    else
      redirect_to "http://#{shortcut.full_url}"
    end
  end

end
