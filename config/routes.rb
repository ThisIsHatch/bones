Bones::Engine.routes.draw do
  get 'components' => 'bones/components#index'
  get 'wireframes/(:action(.:format))', :controller => 'bones/wireframes', as: 'wireframe'
end