Rails.application.routes.draw do
  root 'logins#index'
  resources :tests
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :apis do
    collection do
      get 'registeruser'
      get 'login'
      get 'pactnumber'
      post 'idfont'
      post 'idback'
      get 'registerready'
      get 'uploader'
      post 'attchment'
      get 'getattchment'
      get 'deleteattch'
      get 'pact'
      get 'getseller'
      get 'mypact'
      get 'getopenid'
      get 'getpartid'
      get 'getbuinesname'
      get 'getproduct'
      get 'checkpwd'
      get 'setpwd'
      get 'authpwd'
      get 'getcurrentseller'
      get 'getinvitecode'
      get 'myinvitecode'
      get 'getsalesman'
      get 'getup'
      get 'test'
      get 'sendtest'
      get 'getcommission'
    end
  end
  resources :idcards
  resources :users do
    resources :useramounts
    resources :withdraws
  end
  resources :wxpayments do
    collection do
      get 'information'
      post 'notify'
      get 'payuser'
      get 'manualnotify'
    end
  end
  resources :getopenids
  resources :dgts
  resources :products
  resources :orders
  resources :profits
  resources :admins
  resources :logins
  resources :dgtorders do
    collection do
      get 'sends'
      get 'deldeliveorders'
    end

  end
  resources :delives
  resources :wxusers
  resources :pacts
  resources :dgtfees
  resources :buycars do
    resources :deliveorders
  end
  resources :busines
  resources :userprofits
  resources :rechargeusers do
    collection do
      get 'getuser'
    end
  end
  resources :giveaways do
    resources :giveawaybusines
    resources :giveawayproducts
  end
resources :counts do
  collection do
    get 'mapscount'
  end
end
  #resources :calcommissions
resources :userinoutcounts do

end
end
