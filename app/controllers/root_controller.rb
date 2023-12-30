get "/" do
  @widgets = Widget.all.order(:created_at)

  erb :"root/index"
end
