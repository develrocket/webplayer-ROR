module ApplicationHelper
  # get current page name by controller (used in client side)
  def currentPage(controllers)
    active_class = ''
    controllers.split('//').each do |controller|
      active_class = 'active' if params[:controller] == controller
    end
    active_class
  end
  def current_page_action(action)
    active_class = ''
    action.split('//').each do |name|
      active_class = 'active' if params[:action] == name
    end

    active_class
  end

  def client_navbar_name
    if current_admin.super?
      'Clients'
    else
      if current_admin.agent_type.to_i == 3
        'Agents'
      else 'Profile'
      end
    end
  end

  def admin_error_messages!
    return "" if @admin.errors.empty?
    messages = @admin.errors.full_messages.map { |msg| content_tag(:p, msg, :class => 'custom-col-6 alert alert-danger') }.join

    html = <<-HTML
    <div id="error_explanation">
      <div class="row">#{messages}</div>
    </div>
    HTML

    html.html_safe
  end

  def admin_error_messages?
    @admin.errors.empty? ? false : true
  end

  def tour_error_messages!
    return "" if @tour.errors.empty?
    messages = @tour.errors.full_messages.map { |msg| content_tag(:p, msg, :class => 'custom-col-6 alert alert-danger') }.join

    html = <<-HTML
    <div id="error_explanation">
      <div class="row">#{messages}</div>
    </div>
    HTML

    html.html_safe
  end

  def tour_error_messages?
    @tour.errors.empty? ? false : true
  end
  def error_message object
    return "" if object.errors.empty?
    messages = object.errors.full_messages.map { |msg| content_tag(:p, msg, :class => 'custom-col-6 alert alert-danger') }.join

    html = <<-HTML
    <div id="error_explanation">
      <div class="row">#{messages}</div>
    </div>
    HTML

    html.html_safe
  end

  def current_page_by_tour_id(id)
    if params[:id]
      'active' if params[:id].to_f == id
    else 'active' if @tour.id == id
    end
  end

  def get_embed_code_for_webplayer(tour)
    site_url = get_url_for_webplayer(tour)
    tour.id ? "<iframe src='" + site_url + "' width='" + tour.webplayer_basic.width + "'
                    height='" + tour.webplayer_basic.height + "'><iframe>" : ''
  end
  def get_url_for_webplayer(tour)
    host_url = "http://" + request.host || "http://webplayer-controls.herokuapp.com"
    tour.id ? host_url + '/' + tour.id.to_s : ''
  end

  def get_embed_code_for_branded(tour ,type)
    site_url = get_url_for_webplayer(tour)
    if type == 1
      tour.id ? "<iframe src='" + site_url + "/branded' width='" + tour.webplayer_basic.width + "'
                      height='" + tour.webplayer_basic.height + "'><iframe>" : ''
    else
      tour.id ? "<iframe src='" + site_url + "/tour_branded' width='" + tour.webplayer_basic.width + "'
                      height='" + tour.webplayer_basic.height + "'><iframe>" : ''
    end
  end
  def get_url_for_branded(tour, type)
    host_url = request.host || "http://webplayer-controls.herokuapp.com"
    if type == 1
      tour.id ? host_url + '/' + tour.id.to_s + '/branded' : ''
    else tour.id ? host_url + '/' + tour.id.to_s + '/tour_branded' : '' end
  end

  def get_client_update_url
    if current_admin.super? || params[:action].to_s == 'new' || params[:action].to_s == 'create'
      @store_path
    else update_for_client_path
    end
  end

  def get_agent_name type_id
    if type_id.to_i == 1
      'Individual Agents(Agent Pay / Agent Control)'
    elsif type_id.to_i == 2
      'Brokerage (Brokerage Pay / Brokerage Control)'
    else
      'Individual Agent Company'
    end
  end
end
