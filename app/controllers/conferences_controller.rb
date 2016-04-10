class ConferencesController < ContextsController
  def index
    @contexts = Conference.all
  end
end