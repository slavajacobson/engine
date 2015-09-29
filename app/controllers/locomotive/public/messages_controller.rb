module Locomotive
  module Public
    class MessagesController < Public::BaseController


      before_filter :require_site
      def create
        
        @message = Message.new(params[:message])

      

        
        
        
        if @message.valid?

          current_site.accounts.each do |account|

            Locomotive::Notifications.account_request(account, @message, current_site).deliver
          end


          flash[:alert] = "Your request for an account has been submitted. We'll get back to you shortly."
        else
          flash[:alert] = "Missing or invalid entries. Please check the form."
          
        end

        redirect_to request_account_path
      end

    private

      

    end
  end
end
