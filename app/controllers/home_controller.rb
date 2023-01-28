class HomeController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_admin!, except: [:index]
    def index; end
    # NEW OR EXIST MENU
    def new; end
    # ADD TO EXIST
    def create; end
    
    def reset_seq
        ActiveRecord::Base.connection.reset_pk_sequence!('bills')
        ActiveRecord::Base.connection.reset_pk_sequence!('charges')
        ActiveRecord::Base.connection.reset_pk_sequence!('clients')
        ActiveRecord::Base.connection.reset_pk_sequence!('debts')
        ActiveRecord::Base.connection.reset_pk_sequence!('items')
        ActiveRecord::Base.connection.reset_pk_sequence!('products')
        ActiveRecord::Base.connection.reset_pk_sequence!('sales')
        ActiveRecord::Base.connection.reset_pk_sequence!('stores')
        ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
        ActiveRecord::Base.connection.reset_pk_sequence!('users')
    end
end
