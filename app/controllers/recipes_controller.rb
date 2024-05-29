get "/recipes", auth: :user do
  @recipes = Recipe.all.order(:name)

  erb :"recipes/index"
end
