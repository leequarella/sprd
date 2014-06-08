class SkatersController < ApplicationController
  before_action :set_skater, only: [:show, :edit, :update, :destroy, :practices]

  # GET /skaters
  # GET /skaters.json
  def index
    @skaters = Skater.all
  end

  # GET /skaters/1
  # GET /skaters/1.json
  def show
  end

  # GET /skaters/new
  def new
    @skater = Skater.new
  end

  # GET /skaters/1/edit
  def edit
  end

  # POST /skaters
  # POST /skaters.json
  def create
    @skater = Skater.new(skater_params)

    respond_to do |format|
      if @skater.save
        format.html { redirect_to @skater, notice: 'Skater was successfully created.' }
        format.json { render :show, status: :created, location: @skater }
      else
        format.html { render :new }
        format.json { render json: @skater.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /skaters/1
  # PATCH/PUT /skaters/1.json
  def update
    respond_to do |format|
      if @skater.update(skater_params)
        format.html { redirect_to @skater, notice: 'Skater was successfully updated.' }
        format.json { render :show, status: :ok, location: @skater }
      else
        format.html { render :edit }
        format.json { render json: @skater.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skaters/1
  # DELETE /skaters/1.json
  def destroy
    @skater.destroy
    respond_to do |format|
      format.html { redirect_to skaters_url, notice: 'Skater was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def practices
    report = Struct.new(:start_date, :end_date, :practices, :skater)
    @report = report.new
    @report.skater = @skater
    if params[:start_date]
      @report.start_date = date_from_params params[:start_date]
      @report.end_date   = date_from_params params[:end_date]
    else
      @report.start_date = 1.month.ago
      @report.end_date   = 1.day.from_now
    end
    @report.practices = Practice.where("date > ? and date < ?", @report.start_date,
                                       @report.end_date)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skater
      @skater = Skater.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def skater_params
      params.require(:skater).permit(:first_name, :last_name, :derby_name, :email)
    end
end
