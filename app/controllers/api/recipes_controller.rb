get "/api/recipes" do
  content_type :json

  begin
    response = RecipeSearchService.new(params).call
  rescue
    status 500
    { error: 'an error occurred' }.to_json
    return
  end

  locals = { recipes: response["items"] }
  html = erb(:"recipes/recipe-item", {}, locals)

  status 200
  { html: html }.to_json
end
