class UserPolicy < ApplicationPolicy
  def update? = user&.respond_to?(:admin?) && user.admin?
  def update_permitted_params = [ :name, :locale, :active ]
end
