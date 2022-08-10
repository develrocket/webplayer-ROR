class Auth::PasswordsController < Devise::PasswordsController
  layout 'application_admin'
  before_action :set_login_value
  # GET /resource/password/new
  def new
    super
    @isLoginPage = true
  end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
    @isLoginPage = true
  end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
  private

  def set_login_value
    @isLoginPage = true
  end
end
