class RegistrationsController < Devise::RegistrationsController
  def new
     # Building the resource with information that MAY BE available from omniauth!
     build_resource(:first_name => session[:omniauth] && session[:omniauth]['user_info'] && session[:omniauth]['user_info']['first_name'],
         :last_name => session[:omniauth] && session[:omniauth]['user_info'] && session[:omniauth]['user_info']['last_name'],
         :email => session[:omniauth_email] )
     render :new
  end

  def create
    build_resource

    if session[:omniauth] && @user.errors[:email][0] =~ /has already been taken/
      user = User.find_by_email(@user.email)
      # Link Accounts - if via social connect
      return redirect_to link_accounts_url(user.id)
    end

    # normal processing
    super
    session[:omniauth] = nil unless @user.new_record?
  end

  def build_resource(*args)
    Rails.logger.error "BUILD: #{args.inspect}"
    if args.blank?
      super params.require('user').permit('first_name', 'last_name', 'email', 'password', 'password_confirmation')
    else
      super
    end

    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end

  def after_update_path_for(scope)
    session[:referrer] ? session[:referrer] : root_path
  end
end
