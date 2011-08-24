Rails.application.routes.draw do
  match ':controller(/:action(/:id(.:format)))', :controller => /bones\/[^\/]+/
end
