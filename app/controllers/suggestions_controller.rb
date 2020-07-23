class SuggestionsController < ApplicationController
  def index
    render :index, locals: { suggestions: current_user.suggestions }
  end

  def new
    render :new, locals: { suggestion: Suggestion.new }
  end

  def create
    @suggestion = Suggestion.new(suggestion_params.merge(user: current_user))
    @suggestion.save

    render :create, locals: { suggestion: @suggestion, suggestions: current_user.suggestions.order(created_at: :desc) }
  end

  private

  def suggestion_params
    params.require(:suggestion).permit(:description)
  end
end
