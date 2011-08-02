Rails.application.routes.draw do |map|
  match ':controller(/:action(/:id(.:format)))', :controller => /bones\/[^\/]+/
end
