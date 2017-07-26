require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  let(:user) {FactoryGirl.create(:user)}
  let(:category) {FactoryGirl.create(:category)}
  let(:product) {FactoryGirl.create(:product, category: category)}
  let(:product_1) {FactoryGirl.create(:product, category: category, user: user)} #specifies a spcific user,


  describe "#new" do

    context "with no user signed in" do
      it "redirects to the sign in page" do
        get :new
        expect(response).to redirect_to(new_session_path)
      end

      context "with user signed in" do
        before do
          request.session[:user_id] = user.id
        end

        it "renders the new template" do
          get :new
          expect(response).to render_template(:new)
      end

      it "assigns product instance variable to a new product" do
        get :new
        expect(assigns(:product)).to be_a_new Product
      end
    end
  end
end


  describe "#create" do

    def valid_product
      post :create, params: { product: FactoryGirl.attributes_for(:product) }
    end

    context "with signed in user" do
      before do
        request.session[:user_id] = user.id
      end
      
    context "with valid attributes" do
      it "creates a new product in the database" do

      end
    end

    end

  end


  describe "index" do
    it "assigns an instance variable for all the products" do
      product
      product_1
      get :index
      expect(assigns(:products)).to eq([product_1, product])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "show" do
    before { get :show, params: { id: product.id } }
    #before every action below, it will pass an id in

    it "sets an instance variable with the product whose id is passed in " do
      expect(assigns(:product)).to eq(product)  #go to the controller and assign a variable and see if it matches the variable we pass in
    end

    it "rendeers the show template" do
      expect(response).to render_template(:show)
    end
  end

  describe "destroy" do
    context "with user signed in" do
      context "with non owner signed in" do
        before do
          request.session[:user_id] = user.id
          delete :destroy, { params: { id: product.id } }
        end

        it "sets a flash alert message" do
          expect(flash[:alert]).to be
      end

      it "redirects back to the product page" do
        expect(response).to redirect_to product_path(product)
      end
    end

    context "with product creator signed in" do
      before do
        request.session[:user_id] = user.id
      end

      # it "reduces the number of products in the database by 1" do
      #   product
      #   product_1
      #   before_count= Product.count
      #   delete :destroy, { params: { id: product_1.id } }
      #   after_count = Product.count
      #
      #   expect(after_count).to eq(before_count - 1)
      # end


      #below is equivalent to the one above ^^^^

      it "reduces the number of products by 1" do
        product_1
        expect { delete :destroy, { params: {id: product_1.id} }}.to change { Product.count }.by(-1)
      end

      it "redirects to the products index page" do
        delete :destroy, { params: { id: product_1.id } }
          expect(response).to redirect_to(products_path)
      end

      it "sets a flash notice message" do
        delete :destroy, { params: { id: product_1.id } }
        expect(flash[:notice]).to be
      end
    end
  end


   context "with no user signed in" do
     it "redirects to the sign in page" do
       delete :destroy, params: { id: product.id }
       expect(response).to redirect_to(new_session_path)
     end
   end
end


end ###
