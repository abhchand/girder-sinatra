get "/recipes", auth: :user do
  response = RecipeSearchService.new(params).call

  @recipes = response["items"]
  @sort_by = "created_at"

  erb :"recipes/index"
end
