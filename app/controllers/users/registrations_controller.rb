class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def new
    super
  end

  def create
    super
  end

  def edit
    self.resource = current_user
  end

  #GET /users/edit_name
  def edit_name
    self.resource = current_user
  end

  # PATCH /users/update_name
  def update_name
    self.resource = current_user
    if resource.valid_password?(name_params[:current_password])
      if resource.update(name_params.except(:current_password))
        redirect_to settings_path, notice: "Name updated!"
      else
        render :edit_name, status: :unprocessable_entity
      end
    else
      resource.errors.add(:current_password, "is incorrect")
      render :edit_name, status: :unprocessable_entity
    end
  end

  # GET /users/edit_email
  def edit_email
    self.resource = current_user
  end

  # PATCH /users/update_email
  def update_email
    self.resource = current_user
    if resource.update_with_password(resource_params)
      # successful update; redirect as needed
      redirect_to settings_path, notice: "Email updated!"
    else
      # On failed update: set resource and render form
      clean_up_passwords resource
      render :edit_email, status: :unprocessable_entity
    end
  end

  # GET /users/edit_password
  def edit_password
    self.resource = current_user
  end

  # PATCH /users/update_password
  def update_password
    self.resource = current_user
    if resource.update_with_password(password_update_params)
      bypass_sign_in(resource) # Keeps user signed in after password change
      redirect_to edit_user_password_custom_path, notice: "Password updated!"
    else
      clean_up_passwords resource
      render :edit_password, status: :unprocessable_entity
    end
  end

  # GET /users/settings
  def settings
    self.resource = current_user
    # Optionally set up any variables needed for your settings page
  end

  private

  def resource_params
    params.require(:user).permit(:email, :current_password)
  end

  def password_update_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

  def name_params
    params.require(:user).permit(:first_name, :last_name, :user_name, :current_password)
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :user_name, :agree_to_terms])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :user_name, :agree_to_terms])
  end
end

