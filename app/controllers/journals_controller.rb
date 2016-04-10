class JournalsController < ContextsController
  def index
    @contexts = Journal.all
  end
end