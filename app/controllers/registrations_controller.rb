class RegistrationsController < Devise::RegistrationsController
  def destroy
    redirect_to user_path
  end
end
