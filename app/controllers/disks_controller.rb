# encoding: utf-8
class DisksController < ApplicationController
  before_action :set_disk, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  # GET /disks
  # GET /disks.json
  def index
    @disks = Disk.all
  end

  # GET /disks/1
  # GET /disks/1.json
  def show
  end

  # GET /disks/new
  def new
    @disk = Disk.new
  end

  # GET /disks/1/edit
  def edit
  end

  # POST /disks
  # POST /disks.json
  def create
    @disk = Disk.new(disk_params)

    respond_to do |format|
      if @disk.save
        format.html { redirect_to @disk, notice: 'Disk was successfully created.' }
        format.json { render action: 'show', status: :created, location: @disk }
      else
        format.html { render action: 'new' }
        format.json { render json: @disk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disks/1
  # PATCH/PUT /disks/1.json
  def update
    respond_to do |format|
      if @disk.update(disk_params)
        format.html { redirect_to @disk, notice: 'Disk was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @disk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disks/1
  # DELETE /disks/1.json
  def destroy
    @disk.destroy
    respond_to do |format|
      format.html { redirect_to disks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disk
      @disk = Disk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def disk_params
      params.require(:disk).permit(:width, :image, :diameter_diska, :bolt_count, :bolt_distance, :et, :diameter)
    end
end
