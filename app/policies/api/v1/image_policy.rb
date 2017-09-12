module Api
  module V1
    class ImagePolicy
      attr_reader :user, :record

      def initialize(user, record)
        @user = user
        @record = record[2] # excluding namespace
      end

      def show?
        true
      end

      def index?
        true
      end

      def create?
        @user
      end

      def destroy?
        @user && @user.id == @record.user.id
      end
    end
  end
end
