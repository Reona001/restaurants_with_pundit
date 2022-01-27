class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # we are placing pundit in the application controller so it will be applied to all our controllers
  # it will be applied to all actions
  include Pundit

  # Pundit: white-list approach.
  # It will call a pundit for every existing action unless you place :skip_pundit
  # after every action we are calling verify_authorized method
  # except for index. It will call pundit even if we forget to manually place it.
  # unless: is the scope here and :skip_pundit is a private method we defined.

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # index page is special you have to have verify policy scoped as well as the verify authorized
  # Uncomment when you *really understand* Pundit!

  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  private

  # for admin page and home we are skipping pundit.
  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
    # using regular expression to define URL
    # if you have a user who needs to sign up or if you are in the controller admin or pages you skip pundit.
    # if you have more pages to skip pundit just added it here
  end
end
