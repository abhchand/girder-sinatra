get "/recipes", auth: :user do
  response = RecipeSearchService.new(params).call

  @recipes = response["items"]
  @sort_by = "created_at"
  @pagination = {
    first_num: response["first_num"],
    last_num: response["last_num"],
    total: response["total"]
  }

  erb :"recipes/index"
end
