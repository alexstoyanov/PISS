PISS::Application.routes.draw do

  match '*whatever', :via => [:options, :head], :to => 'options#options'
end
