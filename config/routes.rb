Crewsleep::Application.routes.draw do

  root   to:             "book#app"
  get    "info"       => "book#info"
  get    "list"       => "wakeup#app"

  get    "admin/info" => "admin#info"

  scope module: "api" do

    get    "api/persons/fetch"      => "person#fetch"
    post   "api/persons/:id/book"   => "person#book"

    get    "api/places"             => "place#index"
    get    "api/places/:id"         => "place#show"

    get    "api/alarms/active"      => "alarm#index_active"
    get    "api/alarms/poked"       => "alarm#index_poked"
    post   "api/alarms"             => "alarm#create"
    delete "api/alarms/:id"         => "alarm#destroy"
    post   "api/alarms/:id/finish"  => "alarm#finish"
    post   "api/alarms/:id/poke"    => "alarm#poke"

    get    "api/info"               => "info#show"
    post   "api/info"               => "info#update"

  end

end
