get "/api/recipes" do
  content_type :json

  begin
    response = RecipeSearchService.new(params).call
  rescue => e
    status 500
    { error: "an error occurred: #{e.message}" }.to_json
    return
  end

  locals = { recipes: response["items"], sort_by: params['sort_by'] }
  options = { layout: false }
  html = erb(:"recipes/recipe-item", options, locals)

  status 200
  { html: html }.to_json
end
