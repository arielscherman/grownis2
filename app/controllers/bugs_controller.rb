class BugsController < ApplicationController
  def index
    render :index, locals: { bugs: current_user.bugs }
  end

  def new
    render :new, locals: { bug: Bug.new }
  end

  def create
    @bug = Bug.new(bug_params.merge(user: current_user))
    @bug.save

    render :create, locals: { bug: @bug, bugs: current_user.bugs.order(created_at: :desc) }
  end

  private

  def bug_params
    params.require(:bug).permit(:title, :description)
  end
end
