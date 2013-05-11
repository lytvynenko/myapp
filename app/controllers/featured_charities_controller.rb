class FeaturedCharitiesController < ApplicationController
  # GET /featured_charities
  # GET /featured_charities.json
  def index
    @featured_charities = FeaturedCharity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @featured_charities }
    end
  end

  # GET /featured_charities/1
  # GET /featured_charities/1.json
  def show
    @featured_charity = FeaturedCharity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @featured_charity }
    end
  end

  # GET /featured_charities/new
  # GET /featured_charities/new.json
  def new
    @featured_charity = FeaturedCharity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @featured_charity }
    end
  end

  # GET /featured_charities/1/edit
  def edit
    @featured_charity = FeaturedCharity.find(params[:id])
  end

  # POST /featured_charities
  # POST /featured_charities.json
  def create
    @featured_charity = FeaturedCharity.new(params[:featured_charity])

    respond_to do |format|
      if @featured_charity.save
        format.html { redirect_to @featured_charity, notice: 'Featured charity was successfully created.' }
        format.json { render json: @featured_charity, status: :created, location: @featured_charity }
      else
        format.html { render action: "new" }
        format.json { render json: @featured_charity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /featured_charities/1
  # PUT /featured_charities/1.json
  def update
    @featured_charity = FeaturedCharity.find(params[:id])

    respond_to do |format|
      if @featured_charity.update_attributes(params[:featured_charity])
        format.html { redirect_to @featured_charity, notice: 'Featured charity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @featured_charity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /featured_charities/1
  # DELETE /featured_charities/1.json
  def destroy
    @featured_charity = FeaturedCharity.find(params[:id])
    @featured_charity.destroy

    respond_to do |format|
      format.html { redirect_to featured_charities_url }
      format.json { head :no_content }
    end
  end
end
