class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[ show edit update destroy ]
  
  # GET /products or /products.json
  def index
    @products = Product.all.order('name')
  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.includes(:items).find(params[:id])
  end

  # GET /products/new
  def new
    @product = Product.new
    @product.validity = Date.today.next_year
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @store = Store.first
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        params[:product]['quantity'].to_i.times do
          Item.create(product_id: @product.id, buying_price: params[:product]['buying_price'])
          @store.dorg -= params[:product]['buying_price'].to_i
        end
        @store.save
        format.html { redirect_to '/products/new', notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :selling_price, :whole_sale_price, :quantity, :validity)
    end
end
