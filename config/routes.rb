Bones::Engine.routes.draw do
  get 'components' => 'components#index'
  get '(:action(.:format))', :controller => 'wireframes'
end