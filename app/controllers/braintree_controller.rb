class BraintreeController < ApplicationController
    TRANSACTION_SUCCESS_STATUSES = [
        Braintree::Transaction::Status::Authorizing,
        Braintree::Transaction::Status::Authorized,
        Braintree::Transaction::Status::Settled,
        Braintree::Transaction::Status::SettlementConfirmed,
        Braintree::Transaction::Status::SettlementPending,
        Braintree::Transaction::Status::Settling,
        Braintree::Transaction::Status::SubmittedForSettlement,
      ]
    
      def new
        @client_token = gateway.client_token.generate
        @booking = Booking.find(params[:booking_id])
      end
    
      def show
        @transaction = gateway.transaction.find(params[:result_id])
        @result = _create_result_hash(@transaction)
      end
    
      def create
        amount = Booking.find(params[:booking_id]).price
        nonce = params["payment_method_nonce"]
    
        result = gateway.transaction.sale(
          amount: amount,
          payment_method_nonce: nonce,
          :options => {
            :submit_for_settlement => true
          }
        )
        if result.success? || result.transaction
            Booking.find(params[:booking_id]).update(booking_status: true)
            flash[:success] = "Payment Successful!"
            redirect_to payment_result_path(booking_id: params[:booking_id], result_id: result.transaction.id)
        else
            flash[:error] = "Payment Fail, Try Again"
            redirect_to payment_path(params[:booking_id])
        end
      end
    
      def _create_result_hash(transaction)
        status = transaction.status
    
        if TRANSACTION_SUCCESS_STATUSES.include? status
          result_hash = {
            :header => "Sweet Success!",
            :icon => "success",
            :message => "Your transaction  is successful!"
          }
        else
          result_hash = {
            :header => "Transaction Failed",
            :icon => "fail",
            :message => "Your transaction has a status of #{status}. Please try again."
          }
        end
      end
    
      def gateway
        # env = ENV["BT_ENVIRONMENT"]
        gateway ||= Braintree::Gateway.new(
          :environment => :sandbox,
          :merchant_id => ENV["BRAINTREE_MERCHANT_ID"],
          :public_key => ENV["BRAINTREE_PUBLIC_KEY"],
          :private_key => ENV["BRAINTREE_PRIVATE_KEY"],
        )
      end
    
end
