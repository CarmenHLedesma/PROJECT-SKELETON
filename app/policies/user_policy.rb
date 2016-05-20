class UserPolicy
  attr_reader :user, :usuario

  def initialize(user, usuario)
    @user = user
    @usuario = usuario
  end

  def index?
    @user.admin? || user.super_admin?
  end

  def show?
    @user.admin? || user.super_admin?
    #scope.where(:id => record.id).exists?
  end

  def update?
    @user.admin? || user.super_admin?
  end

  def edit?
    update?
  end



end