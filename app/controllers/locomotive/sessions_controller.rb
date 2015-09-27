module Locomotive
  class SessionsController < ::Devise::SessionsController

    include Locomotive::Routing::SiteDispatcher

    layout '/locomotive/layouts/not_logged_in'

    before_filter :require_site

    before_filter :set_locale

    helper 'locomotive/base'


    # def new
    #   super
    #   byebug
    # end
    protected


    def after_sign_in_path_for(resource)


      if current_locomotive_account.admin?
        pages_path
      elsif current_locomotive_account.viewer?
        request.protocol + request.host_with_port
      end
    end

    def after_sign_out_path_for(resource)
      request.protocol + request.host_with_port
    end

    def set_locale
      I18n.locale = current_site.accounts.first.locale
    end

  end
end
