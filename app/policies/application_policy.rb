# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  # all of these will return a boolean
  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
    # If this is set to false it will return false to all the policies so the user
    # will not be able to create a restaurant
  end

  def new?
    # calling create
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end
end
