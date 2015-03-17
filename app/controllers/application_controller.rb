class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

 before_filter :configure_permitted_parameters, if: :devise_controller?

helper_method :summoner_onboarding, :challenge_onboarding, :prize_onboarding
def summoner_onboarding
	@ignindex_validated = Ignindex.find_by_user_id(current_user.id).summoner_validated
end

def challenge_onboarding
	@status_onboarding = Status.all.where("user_id = ?", current_user.id).count
end

def prize_onboarding
	@prize_onboarding = Geodeliver.find_by_user_id(current_user.id).address
end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :profile_name, :email, :password, :password_confirmation, :remember_me, :summoner_name, :summoner_id) }

  end


end
