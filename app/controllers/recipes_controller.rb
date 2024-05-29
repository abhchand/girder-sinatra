get "/recipes", auth: :user do
  response = RecipeSearchService.new(params).call

  @recipes = response["items"]
  erb :"recipes/index"
end
