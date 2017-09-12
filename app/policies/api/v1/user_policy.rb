module Api
  module V1
    class UserPolicy
      attr_reader :user, :record

      def initialize(user, record)
        @user = user
        @record = record[2]
      end

      def show?
        true
      end

      def index?
        @user.admin?
      end

      def create?
        true
      end

      def destroy?
        @user && @user.id == @record.id
      end

      def token_destroy?
        @user
      end
    end
  end
end
