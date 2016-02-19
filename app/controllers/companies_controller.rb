class CompaniesController < ApplicationController
  load_and_authorize_resource :except => :create
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  before_filter do
    params[:user] &&= user_params
  end

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  def about
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  def administration
    @company = Company.find(params[:id])
    @open_job = OpenJob.new
    @open_job.company = @company
    @open_job.expires = DateTime.now + 2.months
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)
    if current_user
      @company.users << current_user
    end
    @company.save
    flash[:safe] = %Q[Company created! Now #{view_context.link_to("create new open jobs", administration_company_path(@company))}]
    respond_to do |format|
      if @company.save
        format.html { redirect_to @company }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :description, :location, :website)
    end
end
