Bones::Engine.routes.draw do
  get '(:action(.:format))', :controller => 'bones'
  get 'elements' => 'bones/elements'
end