get "/recipes", auth: :user do
  @recipes = Recipe.all.order(:name)
  @icon_share = APP_ROOT.join("public", "images", "icons", "share.svg").read

  erb :"recipes/index"
end
