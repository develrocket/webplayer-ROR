Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admin, controllers: { sessions: "auth/sessions", :registrations => 'auth/registrations', :passwords => 'auth/passwords' },
             :path => 'backend',
             :path_names => { :sign_in => 'login',
                              :sign_up => 'register',
                              :sign_out => 'logout',
                              :password => 'secret',
                              :confirmation => 'verification' } #, :skip => [:sessions]
  # as :admin do
  #   get "backend/login" => "auth/sessions#new"
  #   post "backend/login" => "auth/sessions#create"
  #   get "backend/register" => "auth/registrations#new"
  #   post "backend/register" => "auth/registrations#create"
  # end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#redirect_to_index'

  match '/:id' => 'home#index', via: :get, as: 'home_index', :constraints => { :id => /[0-9]+/ }
  match '/iframe/:id' => 'iframe_home#index', via: :get, as: 'iframe_home_index', :constraints => { :id => /[0-9]+/ }
  match '/:id/branded' => 'home#index_branded', via: :get, as: 'home_index_branded', :constraints => { :id => /[0-9]+/ }
  match '/:id/tour_branded' => 'home#index_tour_branded', via: :get, as: 'home_index_tour_branded', :constraints => { :id => /[0-9]+/ }
  match 'forgot_password' => 'home#generate_new_password_email', via: :post, as: 'generate_new_password_email'

  match 'subscribe_visitor/:id' => 'home#subscribe_visitor', via: :all, as: 'subscribe_visitor'
  match 'get_bootbox1_content/:id' => 'home#load_bootbox1', via: :all, as: 'get_bootbox1_content'
  match 'get_bootbox2_content/:id' => 'home#load_bootbox2', via: :all, as: 'get_bootbox2_content'
  match 'get_bootbox3_content/:id' => 'home#load_bootbox3', via: :all, as: 'get_bootbox3_content'
  match 'get_bootbox4_content/:id' => 'home#load_bootbox4', via: :all, as: 'get_bootbox4_content'
  match ':id/confirm_email/:token' => 'home#confirm_email_by_token', via: :all, as: 'confirm_email_token'
  match 'approve_visitor_access/:token' => 'home#approve_access_by_token', via: :all, as: 'approve_access_by_token'
  match 'add_information_visitor/:id' => 'home#add_information_visitor', via: :all, as: 'add_information_visitor'
  match 'resend_subscribe' => 'home#resend_subscribe_email', via: :all, as: 'resend_subscribe_email'
  match 'store_visit_time' => 'home#store_visit_time', via: :POST, as: 'store_visit_time'

  scope "backend" do
    match '/' => 'backend/tour#index', via: :get, as: 'backend_index' #, :constraints =>lambda { |request| request.env['warden'].user.super? }
    match 'webplayer/:id' => 'backend/client/webplayer_basic#index', via: :get, as: 'webplayer_basic_index'
    match 'webplayer/:id' => 'backend/client/webplayer_basic#store', via: :PATCH, as: 'store_webaplyer_basic'
    match 'webplayer/:id/ajax' => 'backend/client/webplayer_basic#index_ajax', via: :get, as: 'webplayer_basic_ajax_index'

    match 'agent_branding/:id' => 'backend/client/agent_branding#index', via: :get, as: 'agent_branding_index'
    match 'agent_branding/:id' => 'backend/client/agent_branding#store', via: :PATCH, as: 'store_agent_branding'

    match 'tour_branding/:id' => 'backend/client/tour_branding#index', via: :get, as: 'tour_branding_index'
    match 'tour_branding/:id' => 'backend/client/tour_branding#store', via: :PATCH, as: 'store_tour_branding'

    match 'display_content/:id' => 'backend/client/display_content#index', via: :get, as: 'display_content_index'
    match 'display_content/:id' => 'backend/client/display_content#store', via: :PATCH, as: 'store_display_content'

    match 'restrict_option/:id' => 'backend/client/restrict_option#index', via: :get, as: 'restrict_option_index'
    match 'restrict_option/:id' => 'backend/client/restrict_option#store', via: :PATCH, as: 'store_restrict_option'

    match 'visitors_log/:id' => 'backend/client/visitor#index', via: :get, as: 'visitors_log_index'
    match 'visitors_log/:id/detail/:visitor_log_id' => 'backend/client/visitor#detail', via: :all, as: 'visitor_log_detail'
    match 'visitors_log/approve_visitor_access' => 'backend/client/visitor#approve_visitor_access', via: :post, as: 'approve_visitor_access'
    match 'visitors_log/:id/pre_approved_emails' => 'backend/client/visitor#approved_email_list', via: :get, as: 'approved_email_list'
    match 'visitors_log/:id/store_approved_emails' => 'backend/client/visitor#store_approved_email', via: :all, as: 'store_approved_email'
    match 'visitors_log/:id/delete_approved_emails/:approved_email_id' => 'backend/client/visitor#delete_approved_email', via: :all, as: 'delete_approved_email'

    match 'statistic/:id' => 'backend/client/statistic#index', via: :get, as: 'statistic_index'
    match 'statistic/view_custom_by_date' => 'backend/client/statistic#view_custom_by_date', via: :post, as: 'view_custom_by_date'

    # notification in super admin
    match 'notification/:id' => 'backend/admin#notification', via: :get, as: 'notification_index'
    match 'notification/:id' => 'backend/admin#store_notification', via: :PATCH, as: 'store_notification'

    match 'clients' => 'backend/admin#index', via: :get, as: 'client_index'
    match 'clients/add' => 'backend/admin#new', via: :get, as: 'client_add'
    match 'clients/add' => 'backend/admin#create', via: :all, as: 'client_create'
    match 'clients/edit/:id' => 'backend/admin#edit', via: :get, as: 'client_edit'
    match 'clients/edit/:id/ajax' => 'backend/admin#edit_ajax', via: :get, as: 'client_edit_ajax'

    match 'clients/edit/account/:id' => 'backend/admin#edit_account_ajax', via: :get, as: 'client_account_edit_ajax'
    match 'clients/update/account/:id' => 'backend/admin#update_account_ajax', via: :PATCH, as: 'client_account_update_ajax'

    # view client information in client side
    match 'clients/view/:id' => 'backend/admin#view', via: :get, as: 'client_view'
    match 'clients/view/:id/ajax' => 'backend/admin#view_ajax', via: :get, as: 'client_view_ajax'

    # view agents list
    match 'clients/agents_list/:id' => 'backend/admin#agents_list', via: :get, as: 'agents_list'

    match 'clients/update/:id' => 'backend/admin#update', via: :all, as: 'client_update'
    match 'clients/update_for_client/:id' => 'backend/admin#update_for_client', via: :all, as: 'update_for_client'
    match 'clients/delete/:id' => 'backend/admin#delete', via: :delete, as: 'client_delete'
    match 'clients/edit/company/get' => 'backend/admin#get_company_by_id', via: :all, as: 'get_company_by_id1'
    match 'clients/company/get' => 'backend/admin#get_company_by_id', via: :all, as: 'get_company_by_id2'
    match 'clients/:id/tours' => 'backend/admin#client_get_tours', via: :get, as: 'client_get_tours'
    match 'clients/edit/account_create_notification' => 'backend/admin#account_create_notification', via: :post, as: 'account_create_notification'

    scope "tours" do
      match '/' => 'backend/tour#index', via: :get, as: 'tour_index'
      match 'add' => 'backend/tour#new', via: :get, as: 'tour_add'
      match 'add' => 'backend/tour#create', via: :post, as: 'tour_create'

      match 'edit/:id/webplayer_basic' => 'backend/tour#edit_webplayer_basic', via: :get, as: 'tour_edit_webplayer_basic'
      match 'edit/:id/webplayer_basic_ajax' => 'backend/tour#edit_webplayer_basic_ajax', via: :get, as: 'tour_edit_webplayer_basic_ajax'
      match 'edit/:id/webplayer_basic' => 'backend/tour#update_webplayer_basic', via: :patch, as: 'tour_update_webplayer_basic'

      match 'edit/:id/ownership' => 'backend/tour#edit_ownership', via: :get, as: 'tour_edit_ownership'
      match 'edit/:id/ownership' => 'backend/tour#update_ownership', via: :patch, as: 'tour_update_ownership'

      match 'edit/:id/tour_branding' => 'backend/tour#edit_tour_branding', via: :get, as: 'tour_edit_tour_branding'
      match 'edit/:id/tour_branding' => 'backend/tour#update_tour_branding', via: :patch, as: 'tour_update_tour_branding'

      match 'edit/:id/agent_branding' => 'backend/tour#edit_agent_branding', via: :get, as: 'tour_edit_agent_branding'
      match 'edit/:id/agent_branding' => 'backend/tour#update_agent_branding', via: :patch, as: 'tour_update_agent_branding'

      match 'edit/:id/display_contents' => 'backend/tour#edit_display_contents', via: :get, as: 'tour_edit_display_contents'
      match 'edit/:id/display_contents' => 'backend/tour#update_display_contents', via: :patch, as: 'tour_update_display_contents'

      match 'edit/:id/restrict_options' => 'backend/tour#edit_restrict_options', via: :get, as: 'tour_edit_restrict_options'
      match 'edit/:id/restrict_options' => 'backend/tour#update_restrict_options', via: :patch, as: 'tour_update_restrict_options'

      match 'edit/:id/data_log' => 'backend/tour#data_log', via: :get, as: 'tour_data_log'
      match 'edit/:id/data_log/detail/:visitor_log_id' => 'backend/tour#visitor_detail', via: :all, as: 'tour_visitor_log_detail'
      match 'edit/:id/data_log/pre_approved_emails' => 'backend/tour#approved_email_list', via: :get, as: 'tour_approved_email_list'
      match 'edit/:id/data_log/store_approved_emails' => 'backend/tour#store_approved_email', via: :all, as: 'tour_store_approved_email'
      match 'edit/:id/data_log/delete_approved_emails/:approved_email_id' => 'backend/tour#delete_approved_email', via: :all, as: 'tour_delete_approved_email'

      match 'edit/:id/statistic' => 'backend/tour#statistic', via: :get, as: 'tour_statistic_index'

      match 'edit/:id/notification' => 'backend/tour#notification', via: :get, as: 'tour_notification_index'
      match 'edit/:id/notification' => 'backend/tour#store_notification', via: :PATCH, as: 'tour_store_notification'

      match 'edit/:id' => 'backend/tour#update', via: :get, as: 'tour_update'
      match 'delete/:id' => 'backend/tour#delete', via: :delete, as: 'tour_delete'
    end

    match 'client/remove_image' => 'backend/admin#remove_image', via: :post, as: 'remove_image_for_admin'
    match 'tour/remove_image' => 'backend/tour#remove_image', via: :post, as: 'remove_image_for_tour'
    match 'get_admin_by_id' => 'backend/tour#get_admin_by_id', via: :post, as: 'tour_get_admin_by_id'

  end

  get '*unmatched_route', :to => 'application#page_not_found'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
