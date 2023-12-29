get "/" do
  @widgets = Widget.all.order(:created_at)

  erb :index, views: settings.views + '/root'
end
